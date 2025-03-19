open Cohttp_lwt_unix

(* Handles pathing by defaulting to index.html when searching for a folder
   TODO: this should handle other file types *)
let to_index path =
  if path = "/" then "/index.html"
  else if String.length path > 0 && path.[String.length path - 1] = '/' then
    path ^ "index.html"
  else path

(* Generates a path to the resource from the request url *)
let generate_file_path request =
  request |> Request.uri |> Uri.path |> to_index |> ( ^ ) "."

(* Read a file and return its contents as a string *)
let read_file file_path =
  Lwt_io.with_file ~mode:Lwt_io.Input file_path (fun ic -> Lwt_io.read ic)

(* Log the requested file path *)
let log_request file_path = Lwt_io.printf "Requested file: %s\n" file_path

(* Handles the port selection *)
let get_port port_ref =
  (* If the user specified a CLI port, use that. *)
  if port_ref <> -1 then port_ref
  else
    (* Otherwise, fall back to the environment variable or default to 5173. *)
    try int_of_string (Sys.getenv "PORT") with Not_found | Failure _ -> 5173
