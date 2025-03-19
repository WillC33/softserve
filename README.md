# Softserve

Softserve is a lightweight, native HTTP server built in OCaml designed for rapid development and serving static files. With its asynchronous architecture powered by Lwt and Cohttp, Softserve is perfect for local development environments where speed and simplicity are key.

## Features

- **Native & Fast:** Compiled to native code with OCaml’s `ocamlopt` for high performance.
- **Asynchronous:** Uses Lwt for non-blocking, concurrent request handling.
- **Static File Serving:** Serves HTML, CSS, JavaScript, images, and other assets directly.
- **Flexible Port Configuration:** Easily set the port via CLI or environment variable.
- **Simple & Minimal:** Focused on development use, with a clean, modular design.

## Installation

### Prerequisites

- **OCaml:** Make sure you have OCaml installed (via OPAM is recommended).
- **Dune:** The build system used by Softserve.
- **OPAM Dependencies:** Lwt and Cohttp

Install the required libraries with:
```bash
opam install lwt cohttp-lwt-unix alcotest
```

### Building the Project

Clone the repository and build the project using Dune:
```bash
git clone https://github.com/WillC33/softserve.git
cd softserve
dune build
```

### Installing Softserve

To install Softserve into your OPAM switch (or local bin directory), run:
`dune install`
Ensure your installation directory (typically `~/.opam/<switch>/bin`) is in your `PATH`.

## Usage

Run Softserve with the default settings:
`softserve`
By default, Softserve listens on port `5173` (or uses the `PORT` environment variable if set).

To specify a custom port via the command line:
`softserve -p 8080`
This command overrides any environment variable and runs the server on port `8080`.

## Project Structure

```
softserve/
├── bin                    # Contains the main entry point
│   ├── dune               # The Dune for main
│   └── main.ml            # Main
├── dune-project           # The Dune project file
├── lib                    # The lib folder
│   ├── cli.ml             # Contains the cli parsing functions
│   ├── dune               # The Dune for the Softserve library
│   ├── server.ml          # Contains the server callback and on close
│   └── utils.ml           # Utility functions
├── softserve.opam         # The opam file
└── test                   # Test folder
    ├── dune               # The Dune for the test project
    ├── test_softserve.ml  # TODO: integration tests
    └── utils_tests.ml     # The tests for the utils
```

## Testing

Softserve comes with a suite of tests for its utility functions and core functionality.

To run the tests, simply execute:
```bash 
dune runtest
```

This command runs the tests defined in the `test/` directory (using Alcotest) to help ensure that everything works as expected.

## Contributing

Contributions are welcome! If you have suggestions, bug reports, or improvements, please open an issue or submit a pull request.

When contributing:
- Follow the existing code style and documentation guidelines.
- Write tests for new features or bug fixes.
- Ensure that your changes do not break existing functionality.

## License

Softserve is open source and distributed under the [BSD 3-Clause License](LICENSE).
