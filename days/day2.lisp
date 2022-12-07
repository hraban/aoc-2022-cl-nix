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

(uiop:define-package #:aoc-2022x/days/day2
  (:use #:cl #:arrow-macros :aoc-2022x/days/utils)
  (:import-from #:infix-math #:$)
  (:local-nicknames (#:clu #:cl-utilities))
  (:export #:day2))

(in-package #:aoc-2022x/days/day2)

;; Rock, Paper, Scissors:
;; R = 0, P = 1, S = 2

(defun score1 (o m)
  ($ ((m - o + 1) mod 3) * 3
     + m + 1))

(defun score2 (o m)
  ($ 3m
     +
     ((o + m - 1) mod 3) + 1))

(defun parse-line (o _ m)
  ($ (list ((char-code o) - (char-code #\A))
           ((char-code m) - (char-code #\X)))))

(defun line (str)
  (->> str
       (concatenate 'list)
       (apply #'parse-line)))

(defun day2 (&optional part)
  (->> (read-lines)
       (mapcar #'line)
       (amapcar (if (string= part "2") #'score2 #'score1))
       sum
       print))
