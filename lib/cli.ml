(* Command line arguments for the server and client *)

(** Reference to the port number for the client
    *)
let cli_port = ref (-1)

(** Command line arguments for the server
    Currently the only option is -p for the port
    *)
let speclist = [ ("-p", Arg.Int (fun p -> cli_port := p), "Port to listen on") ]

(** Usage message for the server
    Currently the only option is -p for the port
    *)
let usage_msg = "Usage: server [-p <port>]"

(** Parse the command line arguments 
    *)
let parse_args () = Arg.parse speclist (fun _anon -> ()) usage_msg
