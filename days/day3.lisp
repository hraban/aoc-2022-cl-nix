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

(defpackage #:aoc-2022x/days/day3
  (:use #:cl #:arrow-macros
        #:aoc-2022x/utils)
  (:local-nicknames (#:clu #:cl-utilities))
  (:export #:day3))

(in-package #:aoc-2022x/days/day3)

(defun split (l)
  (let ((half (/ (length l) 2)))
    (list (subseq l 0 half)
          (subseq l half))))

(defun score (c)
  (1+ (if (lower-case-p c)
          (- (char-code c) (char-code #\a))
          (+ 26 (- (char-code c) (char-code #\A))))))

(defun process1-line (s)
  (->> s
       (concatenate 'list)
       split
       (apply #'intersection)
       first
       score))

(defun process1 (lines)
  (->> lines
       (mapcar #'process1-line)
       sum))

(defun process2 (l)
  (error "Todo"))

(defun day3 (&optional arg)
  (->> (read-lines)
       (funcall (if (equal arg "2") #'process2 #'process1))
       (format T "~A~%")))
