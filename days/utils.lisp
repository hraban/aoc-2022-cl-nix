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

(uiop:define-package #:aoc-2022x/days/utils
  (:use #:cl #:arrow-macros)
  (:export #:read-lines #:to-int))

(in-package #:aoc-2022x/days/utils)

(defun read-lines ()
  (loop :for line = (read-line nil nil) :while line :collect line))

(defun to-int (x)
  (unless (equal x "")
    (parse-integer x)))

(defun sum (l)
  (reduce #'+ l))
