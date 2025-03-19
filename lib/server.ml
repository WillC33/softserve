open Lwt.Infix
open Cohttp_lwt_unix

(* Handles the responses to server actions *)
let server_callback _conn req _body =
  let file_path = Utils.generate_file_path req in
  Lwt.catch
    (fun () ->
      Printf.printf "Requested file: %s\n%!" file_path;
      Utils.read_file file_path >>= fun content ->
      Printf.printf "200: Resource found\n";
      Server.respond_string ~status:`OK ~body:content ())
    (fun _exn ->
      (* If reading the file fails, return a 404 response *)
      Printf.printf "404: Resource not found\n";
      Server.respond_not_found ())

(* Handles the server's action on connection closed *)
let conn_closed _conn = Printf.printf "Connection closed\n%!"
