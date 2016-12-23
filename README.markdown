# Themuse - Take home challenge for The Muse

## Usage

Building production assets

```sh
cd assets/
./build.sh  # builds the js
./css.sh    # compiles the sass
```

Running the app

```sh
sbcl --eval "(ql:quickload :themuse)" --eval "(nest:start themuse::app)"
```

## Installation

Most requirements are available in quicklisp, but the app also depends on the `nest` web framework from [gitlab.com/knttl/nest](https://gitlab.com/knttl/nest).

Building assets depends on

* [uglifyjs](https://www.npmjs.com/package/uglify-js)
* [elm](https://www.npmjs.com/package/uglify-js)
* [sassc](https://github.com/sass/sassc)

## Author

* Matt Novenstern (matt.novenstern@gmail.com)

## Copyright

Copyright (c) 2016 Matt Novenstern (matt.novenstern@gmail.com)

## License

Licensed under the Secret License.
