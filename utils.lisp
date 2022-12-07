;; Copyright © 2022  Hraban Luyat
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU Affero General Public License as published
;; by the Free Software Foundation, version 3 of the License.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU Affero General Public License for more details.
;;
;; You should have received a copy of the GNU Affero General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

(uiop:define-package #:aoc-2022x/utils
  (:use #:cl #:arrow-macros)
  (:local-nicknames (#:alex #:alexandria))
  (:export #:read-lines #:to-int #:sum #:amapcar))

(in-package #:aoc-2022x/utils)

(defun read-lines ()
  (loop :for line = (read-line nil nil) :while line :collect line))

(defun to-int (x)
  (unless (equal x "")
    (parse-integer x)))

(defun sum (l)
  (reduce #'+ l))

(defun amapcar (f &rest ls)
  "Like mapcar but assumes every element of l is a list of args to apply"
  (apply #'mapcar (alex:curry #'apply f) ls))
