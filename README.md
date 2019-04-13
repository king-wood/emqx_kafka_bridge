# EMQ emq\_kafka\_bridge编译流程

* **OS system version: centos-7.2**
* **erlang version: otp\_src\_20**
* **emq version: emqx-rel-2.3.11**
* **emq\_kafka\_bridge plugin source code gitlab:** 
https://git.ucloudadmin.com/uiot/emq\_kafka\_bridge.git

### 一、创建编译环境

#### 安装系统必要依赖:
  
    sudo yum install -y gcc gcc-c++ glibc-devel make ncurses-devel openssl-devel autoconf java-1.8.0-openjdk-devel git
  
#### 源码编译安装erlang环境:
  
    wget http://erlang.org/download/otp_src_20.0.tar.gz
    tar xvf otp_src_20.tar.gz
    cd otp_src_20.0/
    ./configure  --prefix=/root/erlang
    make && make install
  
#### 添加对应的环境变量:

    vim /etc/profile
      export PATH=/root/erlang/bin:$PATH 
    source /etc/profile

### 二、获取emq\_kafka\_bridge 插件,修改源码

    git clone https://git.ucloudadmin.com/uiot/emq_kafka_bridge.git

本地修改源码后，打tag，推送。
  
### 三、编译安装emq
  
#### 下载emq-2.3.11

    wget https://git.ucloudadmin.com/uiot/emqx_rel_2.3.11/-/archive/master/emqx_rel_2.3.11-master.tar.gz
    tar xzvf emqx-rel-2.3.11.tar.gz
    cd emqx-rel-2.3.11

#### 修改配置文件
  
修改Makefile文件，注意替换tag版本号:

    DEPS += emq_kafka_bridge
    dep_emq_kafka_bridge  = git https://git.ucloudadmin.com/uiot/emq_kafka_bridge.git {git_tag_version}
  
修改relx.config文件,添加如下行:

    {emq_kafka_bridge, load},

#### 编译

    make clean 
    sudo rm -r /root/emqx-rel-2.3.11/deps/emq_kafka_bridge
    make  
  
**编译结果在\_rel文件中**

### 四、启动关闭服务

配置kafka插件:

在这里可以修改对应的kafka Topic名，负载方式，work数量。

    vim /root/emqx-rel-2.3.11/_rel/emqttd/etc/plugins/emq_kafka_bridge.conf

    配置kafka.host

启动emq以及载入插件:

    /root/emqx-rel-2.3.11/_rel/emqttd/bin/emqttd start 
    /root/emqx-rel-2.3.11/_rel/emqttd/bin/emqttd_ctl plugins load emq_kafka_bridge

卸载插件以及关闭emq:
  
    /root/emqx-rel-2.3.11/_rel/emqttd/bin/emqttd_ctl plugins unload emq_kafka_bridge
    /root/emqx-rel-2.3.11/_rel/emqttd/bin/emqttd sto