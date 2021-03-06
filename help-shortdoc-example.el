;;; help-shortdoc-example.el --- Display shortdoc examples to *Help* buffer -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Taiki Sugawara

;; Author: Taiki Sugawara <buzz.taiki@gmail.com>
;; URL: https://github.com/buzztaiki/help-shortdoc-example.el
;; Version: 0.0.1
;; Package-Requires: ((emacs "28.1"))
;; Keywords: help

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This package allows to display shortdoc examples to *Help* buffer.
;; To use it, add the following to your init file:
;;
;;         (help-shortdoc-example-mode 1)
;;
;; For more information, please see <https://github.com/buzztaiki/help-shortdoc-example.el>.

;;; Code:

(require 'shortdoc)
(require 'help-fns)

(defgroup help-shortdoc-example nil
  "Display shortdoc examples to *Help* buffer."
  :group 'help)

;;;###autoload
(defun help-shortdoc-example (function)
  "Insert shortdoc examples of FUNCTION."
  (when-let ((groups (and (symbolp function) (shortdoc-function-groups function))))
    (save-restriction
      (narrow-to-region (point) (point))
      (insert "\nExamples:\n")
      (dolist (group groups)
        (save-restriction
          (narrow-to-region (point) (point))
          (shortdoc--display-function (assq function (cdr (assq group shortdoc--groups))))
          (save-excursion
            (goto-char (point-min))
            (when (re-search-forward "^  (" nil t)
              (delete-region (point-min) (match-beginning 0))))))
      (indent-rigidly (point-min) (point-max) 2))))

;;;###autoload
(define-minor-mode help-shortdoc-example-mode
  "Display shortdoc examples to *Help* buffer."
  :global t
  (if help-shortdoc-example-mode
      (add-hook 'help-fns-describe-function-functions #'help-shortdoc-example 100)
    (remove-hook 'help-fns-describe-function-functions #'help-shortdoc-example)))

(provide 'help-shortdoc-example)
;;; help-shortdoc-example.el ends here
