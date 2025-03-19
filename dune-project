(lang dune 3.16)

(name softserve)

(generate_opam_files true)

(source
 (github WillC33/softserve))

(authors "William Cooke")

(maintainers "William Cooke")

(license BSD-3-Clause)

(documentation https://url/to/documentation)

(package
 (name softserve)
 (synopsis "Softserve is a straightforward development server --- created in beautiful, functional OCaml")
 (description "Softserve is a simple Http server for development projects as an alternative to Python and Node for running projects with a fast native binary server")
 (depends ocaml dune)
 (tags
  (topics "Http, DevTools" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
