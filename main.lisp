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

(uiop:define-package #:aoc-2022x
  (:nicknames #:aoc-2022x/main)
  (:use #:cl)
  (:import-from #:aoc-2022x/days/day1)
  (:import-from #:aoc-2022x/days/day2)
  (:export #:main))

(in-package #:aoc-2022x/main)

(defun main-aux (day &rest etc)
  ;; 🤷 whatever
  (apply (find-symbol (string-upcase day)
                      (format NIL "AOC-2022X/DAYS/~:@(~A~)" day))
         etc))

(defun main ()
  (apply #'main-aux (uiop:command-line-arguments)))
