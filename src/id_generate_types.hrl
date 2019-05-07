-ifndef(_id_generate_types_included).
-define(_id_generate_types_included, yeah).

%% struct 'WorkId'

-record('WorkId', {'work' :: string() | binary()}).
-type 'WorkId'() :: #'WorkId'{}.

-endif.
