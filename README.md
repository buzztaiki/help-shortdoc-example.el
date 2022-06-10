# help-shortdoc

This package allows to output shortdoc examples to `*Help*` buffer.

## Usage

Add the following to your init file:

```lisp
(help-shortdoc-mode 1)
```

For example, if you type `M-x describe-function car`, the following will be output:

```
car is a built-in function in ‘src/data.c’.

(car LIST)

Return the car of LIST.  If LIST is nil, return nil.
Error if LIST is not nil and not a cons cell.  See also ‘car-safe’.

See Info node ‘(elisp)Cons Cells’ for a discussion of related basic
Lisp concepts such as car, cdr, cons cell and list.

  Other relevant functions are documented in the list group.
  Probably introduced at or before Emacs version 1.2.
  This function does not change global state, including the match data.

Examples:

  (car '(one two three))
    ⇒ one
  (car '(one . two))
    ⇒ one
  (car nil)
    ⇒ nil

[back]
```

## License

GPLv3
