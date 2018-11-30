;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname assignment-6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;;;;-----------------DATA DEFINITIONS------------------------

;; A Location is a Posn
;; INTERP: represents a location of a spaceship

;; Deconstructor Template
#; (define (location-fn location)
     ... (posn-x location) ...
     ... (posn-y location) ...)

(define LEFT 'left)
(define RIGHT 'right)

;; A Direction is one of
;; - LEFT
;; - RIGHT
;; INTERP: represents the spaceship's moving direction

;; Deconstructor Template
;; direction-fn: Direction -> ???
#; (define (direction-fn direction)
     (cond
       [(symbol=? LEFT direction) ...]
       [(symbol=? RIGHT direction) ...]))

;; A Lives is a NonNegInteger
;; WHERE: Lives is in the range [0,3]
;; INTERP: represents the lives of the spaceship

(define-struct spaceship (loc dir lives))
;; A Spaceship is (make-spaceship Location Direction Lives)
;; INTERP: represents a spaceship with its current location,
;; the moving direction and remaining lives

;; Deconstructor Template
;; spaceship-fn: Spaceship -> ???
#; (define (spaceship-fn spaceship)
     ... (location-fn (spaceship-loc spaceship)) ...
     ... (direction-fn (spaceship-dir spaceship)) ...
     ... (spaceship-lives spaceship) ...)

;; An Invader is a Posn
;; INTERP: represents the location of an invader

;; Deconstructor Template
;; invader-fn: Invader -> ???
#; (define (invader-fn invader)
     ... (posn-x invader) ...
     ... (posn-y invader) ...)

;; A List of Invaders (LoI) is one of
;; - empty
;; - (cons Invader LoI)
;; INTERP: represents a list of invaders

;; Deconstructor Template
;; loi-fn: LoI -> ???
#; (define (loi-fn loi)
     (cond
       [(empty? loi) ...]
       [(cons? loi) ... (invader-fn (first loi)) ...
                    ... (loi-fn (rest loi)) ...]))

(define-struct invaders (loi ticks))
;; An Invaders is a (make-invaders LoI PosInteger);
;; INTERP: represents the invaders with the list of locations,
;; and the number of ticks before the invaders moving down by
;; INVADER-SPEED

;;;; Deconstructor Template
;; invaders-fn: Invaders -> ???
#; (define (invaders-fn invaders)
     ... (loi-fn (invaders-loi invaders)) ...
     ... (invaders-ticks invaders) ...)

;; A Bullet is a Posn
;; INTERP: represents the location of a bullet

;; Deconstructor Template
;; bullet-fn: Bullet -> ???
#; (define (bullet-fn bullet)
     ... (posn-x bullet) ...
     ... (posn-y bullet) ...)

;; A list of Bullets (LoB) is one of
;; - empty
;; (cons Bullet LoB)
;; INTERP: represents a list of bullets

;; Deconstructor Template
;; lob-fn: LoB -> ???
#; (define (lob-fn lob)
     (cond
       [(empty? lob) ...]
       [(cons? lob) ... (bullet-fn (first lob)) ...
                    ... (lob-fn (rest lob)) ...]))

(define-struct world (spaceship invaders ship-bullets invader-bullets score))
;; A world is (make-world Spaceship Invaders LoB LoB NonNegInteger)
;; INTERP: spaceship represents the spaceship
;;         invaders represents the current invaders
;;         ship-bullets represents the in-flight spaceship bullets
;;         invader-bullets represents the in-flight invader bullets
;;         score represents the current score

;; Deconstructor Template
;; world-fn: World -> ???
#; (define (world-fn world)
     ... (spaceship-fn (world-spaceship world)) ...
     ... (invaders-fn (world-invaders world)) ...
     ... (lob-fn (world-ship-bullets world)) ...
     ... (lob-fn (world-invader-bullets world)) ...
     ... (world-score world) ...)

;;;;-----------------DEFINE CONSTANTS------------------------

(define WIDTH 500)
(define HEIGHT 700)
(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define SHIP-WIDTH 30)
(define SHIP-HEIGHT 15)
(define SPACESHIP-IMAGE (rectangle SHIP-WIDTH SHIP-HEIGHT 'solid 'black))
(define SHIP-POSNX 250)
(define SHIP-POSNY 650)
(define SHIP-INIT-POSN (make-posn SHIP-POSNX SHIP-POSNY))
(define MAX-LIVES 3)
(define THREE 3)
(define TWO 2)
(define ONE 1)
(define ZERO 0)

(define INVADER-SIDE 20)
(define INVADER-IMAGE (square INVADER-SIDE 'solid 'red))
(define MIN-X 90)
(define MAX-X 410)
(define MIN-Y 90)
(define MAX-Y 180)
(define PLUS-X 40)
(define PLUS-Y 30)
(define INVADER-NUM 36)

(define BULLET-RADIUS 5)
(define SHIP-BULLET-IMAGE (circle BULLET-RADIUS 'solid 'black))
(define INVADER-BULLET-IMAGE (circle BULLET-RADIUS 'solid 'red))

(define SHIP-SPEED 10)
(define INVADER-SPEED 10)
(define S-BULLET-SPEED 20)
(define I-BULLET-SPEED 8)


(define MAX-SHIP-BULLETS 3)
(define MAX-INVADER-BULLETS 10)

(define TEXT-SIZE 24)
(define TEXT-COLOR "blue")
(define LIVES-POSN (make-posn 400 670))
(define SCORE-POSN (make-posn 250 30))

(define TICKS 40)
(define POINTS-PER-HIT 3)

(define SPACESHIP-INIT (make-spaceship SHIP-INIT-POSN RIGHT MAX-LIVES))
(define LOI-INIT
  (list (make-posn MIN-X MIN-Y)
        (make-posn (+ MIN-X PLUS-X) MIN-Y)
        (make-posn (+ MIN-X (* 2 PLUS-X)) MIN-Y)
        (make-posn (+ MIN-X (* 3 PLUS-X)) MIN-Y)
        (make-posn (+ MIN-X (* 4 PLUS-X)) MIN-Y)
        (make-posn (+ MIN-X (* 5 PLUS-X)) MIN-Y)
        (make-posn (+ MIN-X (* 6 PLUS-X)) MIN-Y)
        (make-posn (+ MIN-X (* 7 PLUS-X)) MIN-Y)
        (make-posn (+ MIN-X (* 8 PLUS-X)) MIN-Y)
        (make-posn MIN-X (+ MIN-Y PLUS-Y))
        (make-posn (+ MIN-X PLUS-X) (+ MIN-Y PLUS-Y))
        (make-posn (+ MIN-X (* 2 PLUS-X)) (+ MIN-Y PLUS-Y))
        (make-posn (+ MIN-X (* 3 PLUS-X)) (+ MIN-Y PLUS-Y))
        (make-posn (+ MIN-X (* 4 PLUS-X)) (+ MIN-Y PLUS-Y))
        (make-posn (+ MIN-X (* 5 PLUS-X)) (+ MIN-Y PLUS-Y))
        (make-posn (+ MIN-X (* 6 PLUS-X)) (+ MIN-Y PLUS-Y))
        (make-posn (+ MIN-X (* 7 PLUS-X)) (+ MIN-Y PLUS-Y))
        (make-posn (+ MIN-X (* 8 PLUS-X)) (+ MIN-Y PLUS-Y))
        (make-posn MIN-X (+ MIN-Y (* 2 PLUS-Y)))
        (make-posn (+ MIN-X PLUS-X) (+ MIN-Y (* 2 PLUS-Y)))
        (make-posn (+ MIN-X (* 2 PLUS-X)) (+ MIN-Y (* 2 PLUS-Y)))
        (make-posn (+ MIN-X (* 3 PLUS-X)) (+ MIN-Y (* 2 PLUS-Y)))
        (make-posn (+ MIN-X (* 4 PLUS-X)) (+ MIN-Y (* 2 PLUS-Y)))
        (make-posn (+ MIN-X (* 5 PLUS-X)) (+ MIN-Y (* 2 PLUS-Y)))
        (make-posn (+ MIN-X (* 6 PLUS-X)) (+ MIN-Y (* 2 PLUS-Y)))
        (make-posn (+ MIN-X (* 7 PLUS-X)) (+ MIN-Y (* 2 PLUS-Y)))
        (make-posn (+ MIN-X (* 8 PLUS-X)) (+ MIN-Y (* 2 PLUS-Y)))
        (make-posn MIN-X (+ MIN-Y (* 3 PLUS-Y)))
        (make-posn (+ MIN-X PLUS-X) (+ MIN-Y (* 3 PLUS-Y)))
        (make-posn (+ MIN-X (* 2 PLUS-X)) (+ MIN-Y (* 3 PLUS-Y)))
        (make-posn (+ MIN-X (* 3 PLUS-X)) (+ MIN-Y (* 3 PLUS-Y)))
        (make-posn (+ MIN-X (* 4 PLUS-X)) (+ MIN-Y (* 3 PLUS-Y)))
        (make-posn (+ MIN-X (* 5 PLUS-X)) (+ MIN-Y (* 3 PLUS-Y)))
        (make-posn (+ MIN-X (* 6 PLUS-X)) (+ MIN-Y (* 3 PLUS-Y)))
        (make-posn (+ MIN-X (* 7 PLUS-X)) (+ MIN-Y (* 3 PLUS-Y)))
        (make-posn (+ MIN-X (* 8 PLUS-X)) (+ MIN-Y (* 3 PLUS-Y)))))
(define INVADERS-INIT (make-invaders LOI-INIT TICKS))
(define WORLD-INIT (make-world
                    SPACESHIP-INIT INVADERS-INIT empty empty ZERO))

;;;;-----------------DRAW WORLD------------------------
(define SPACESHIP-TEST (make-spaceship (make-posn 200 650)
                                    RIGHT
                                    2))
(define INVADERS-TEST  (make-invaders (list (make-posn 170 90)
                                       (make-posn 210 120)
                                       (make-posn 250 150))
                                  10))
(define S-BULLETS-TEST (list (make-posn 200 400)
                         (make-posn 150 300)))
(define I-BULLETS-TEST  (list (make-posn 100 400)
                         (make-posn 200 300)))
(define SCORE-TEST 30)
(define WORLD-TEST1 (make-world
                    SPACESHIP-TEST
                    INVADERS-TEST
                    S-BULLETS-TEST
                    I-BULLETS-TEST
                    SCORE-TEST))
(define MTLOP empty)

;;;; Signature
;; draw-world: World -> Image
;;;; Purpose
;; GIVEN: a world 
;; RETURNS: an image representation of the given world
;;;; Function Definition
(define (draw-world w)
  (draw-score (world-score w)
  (draw-invader-bullets (world-invader-bullets w)
  (draw-ship-bullets (world-ship-bullets w)
                     (draw-invaders (world-invaders w)
                                    (draw-spaceship (world-spaceship w)))))))
;;;; Tests
(check-expect (draw-world WORLD-INIT)
  (draw-score (world-score WORLD-INIT)
  (draw-invader-bullets (world-invader-bullets WORLD-INIT)
  (draw-ship-bullets (world-ship-bullets WORLD-INIT)
                     (draw-invaders (world-invaders WORLD-INIT)
                      (draw-spaceship (world-spaceship WORLD-INIT)))))))

(check-expect (draw-world WORLD-TEST1)
  (draw-score (world-score WORLD-TEST1)
  (draw-invader-bullets (world-invader-bullets WORLD-TEST1)
  (draw-ship-bullets (world-ship-bullets WORLD-TEST1)
                     (draw-invaders (world-invaders WORLD-TEST1)
                      (draw-spaceship (world-spaceship WORLD-TEST1)))))))


;;;; Signature
;; draw-spaceship: SPACESHIP -> Image
;;;; Purpose
;; GIVEN: a spaceship
;; RETURNS: an image representation of the spaceship
;;;; Function Definition
(define (draw-spaceship ship)
  (draw-lives (spaceship-lives ship)
              (draw-spaceship-image (spaceship-loc ship))))
;;;; Tests 
(check-expect (draw-spaceship SPACESHIP-INIT)
   (place-image SPACESHIP-IMAGE
                           SHIP-POSNX
                           SHIP-POSNY
   (place-image (text (string-append "Remaining Lives: "
                                          (number->string MAX-LIVES))
                            TEXT-SIZE
                            TEXT-COLOR)
                     (posn-x LIVES-POSN)
                     (posn-y LIVES-POSN)
                     BACKGROUND)))

(check-expect (draw-spaceship SPACESHIP-TEST)
   (place-image SPACESHIP-IMAGE
                           200
                           650
   (place-image (text (string-append "Remaining Lives: "
                                          (number->string 2))
                            TEXT-SIZE
                            TEXT-COLOR)
                     (posn-x LIVES-POSN)
                     (posn-y LIVES-POSN)
                     BACKGROUND)))


;;;; Signature
;; draw-spaceship-image: Location -> Image
;;;; Purpose
;; GIVEN: a spaceship's location
;; RETURNS: an image representation of the spaceship's shape
;; in its location
;;;; Function Definition
(define (draw-spaceship-image loc)
  (place-image SPACESHIP-IMAGE
               (posn-x loc)
               (posn-y loc)
               BACKGROUND))
;;;; Tests
(check-expect (draw-spaceship-image SHIP-INIT-POSN)
              (place-image SPACESHIP-IMAGE
                           SHIP-POSNX
                           SHIP-POSNY
                           BACKGROUND))                   
(check-expect (draw-spaceship-image (make-posn 200 650))
              (place-image SPACESHIP-IMAGE
                           200
                           650
                           BACKGROUND))


;;;; Signature
;; draw-lives: Lives Image -> Image
;;;; Purpose
;; GIVEN: a lives and an image
;; RETURNS: an image representation of the lives on the given image
;;;; Function Definition
(define (draw-lives num image)
  (place-image (text (string-append "Remaining Lives: "
                                          (number->string num))
                            TEXT-SIZE
                            TEXT-COLOR)
                     (posn-x LIVES-POSN)
                     (posn-y LIVES-POSN)
                     image))
;;;; Tests
(check-expect (draw-lives MAX-LIVES BACKGROUND)
              (place-image (text (string-append "Remaining Lives: "
                                          (number->string MAX-LIVES))
                            TEXT-SIZE
                            TEXT-COLOR)
                     (posn-x LIVES-POSN)
                     (posn-y LIVES-POSN)
                     BACKGROUND))
(check-expect (draw-lives TWO BACKGROUND)
              (place-image (text (string-append "Remaining Lives: "
                                          (number->string TWO))
                            TEXT-SIZE
                            TEXT-COLOR)
                     (posn-x LIVES-POSN)
                     (posn-y LIVES-POSN)
                     BACKGROUND))


;;;; Signature
;; draw-invaders: Invaders Image -> Image
;;;; Purpose
;; GIVEN: a invaders and an image
;; RETURNS: an image representation of the invaders on the given image
;;;; Function Definition
(define (draw-invaders invaders image)
  (draw-loi (invaders-loi invaders) image))
;;;; Tests
(check-expect (draw-invaders INVADERS-INIT BACKGROUND)
     (draw-loi (invaders-loi INVADERS-INIT) BACKGROUND))
(check-expect (draw-invaders INVADERS-TEST BACKGROUND)
     (draw-loi (invaders-loi INVADERS-TEST) BACKGROUND))


;;;; Signature
;; draw-loi: LoI Image -> Image
;;;; Purpose
;; GIVEN: a list of invaders and an image
;; RETURNS: an image representation of the list of invaders on the given image
;;;; Function Definition
(define (draw-loi loi image)
  (cond
    [(empty? loi) image]
    [(cons? loi) (place-image INVADER-IMAGE
                              (posn-x (first loi))
                              (posn-y (first loi))
                              (draw-loi (rest loi) image))]))
;;;; Tests
(check-expect (draw-loi MTLOP BACKGROUND) BACKGROUND)
(check-expect (draw-loi (invaders-loi INVADERS-TEST) BACKGROUND)
   (place-image INVADER-IMAGE
                170
                90
                (place-image INVADER-IMAGE
                              210
                              120
                             (place-image INVADER-IMAGE
                             250
                             150
                             BACKGROUND))))


;;;; Signature
;; draw-ship-bullets: LoB Image -> Image
;;;; Purpose
;; GIVEN: a list of spaceship bullets and an image
;; RETURNS: an image representation of the spaceship bullets on the given image
;;;; Function Definition
(define (draw-ship-bullets lob image)
  (cond
    [(empty? lob) image]
    [(cons? lob) (place-image SHIP-BULLET-IMAGE
                              (posn-x (first lob))
                              (posn-y (first lob))
                              (draw-ship-bullets (rest lob) image))]))
;;;; Tests
(check-expect (draw-ship-bullets empty BACKGROUND) BACKGROUND)
(check-expect (draw-ship-bullets S-BULLETS-TEST BACKGROUND)
              (place-image SHIP-BULLET-IMAGE
                           200
                           400
                           (place-image SHIP-BULLET-IMAGE
                                        150
                                        300
                                        BACKGROUND)))


;;;; Signature
;; draw-invader-bullets: LoB Image -> Image
;;;; Purpose
;; GIVEN: a list of invader bullets and an image
;; RETURNS: an image representation of the invader bullets on the given image
;;;; Function Definition
(define (draw-invader-bullets lob image)
  (cond
    [(empty? lob) image]
    [(cons? lob) (place-image INVADER-BULLET-IMAGE
                              (posn-x (first lob))
                              (posn-y (first lob))
                              (draw-invader-bullets (rest lob) image))]))
;;;; Tests
(check-expect (draw-invader-bullets empty BACKGROUND) BACKGROUND)
(check-expect (draw-invader-bullets I-BULLETS-TEST BACKGROUND)
              (place-image INVADER-BULLET-IMAGE
                           100
                           400
                           (place-image INVADER-BULLET-IMAGE
                                        200
                                        300
                                        BACKGROUND)))


;;;; Signature
;; draw-score: NonNegInteger Image -> Image
;;;; Purpose
;; GIVEN: a non-negative integer and an image
;; RETURNS: an image representation of the integer on the given image
;;;; Function Definition
(define (draw-score num image)
  (place-image (text (string-append "Score: "
                                          (number->string num))
                            TEXT-SIZE
                            TEXT-COLOR)
                     (posn-x SCORE-POSN)
                     (posn-y SCORE-POSN)
                     image))
;;;; Test
(check-expect (draw-score ZERO BACKGROUND)
              (place-image (text (string-append "Score: "
                                          (number->string ZERO))
                            TEXT-SIZE
                            TEXT-COLOR)
                     (posn-x SCORE-POSN)
                     (posn-y SCORE-POSN)
                     BACKGROUND))
(check-expect (draw-score SCORE-TEST BACKGROUND)
              (place-image (text (string-append "Score: "
                                          (number->string SCORE-TEST))
                            TEXT-SIZE
                            TEXT-COLOR)
                     (posn-x SCORE-POSN)
                     (posn-y SCORE-POSN)
                     BACKGROUND))



;;;;-----------------MOVE SPACESHIP------------------------


(define SHIP1 (make-spaceship
               (make-posn 300 650)
               LEFT
               2))
(define NEW-SHIP1 (make-spaceship
               (make-posn (- 300 SHIP-SPEED) 650)
               LEFT
               2))
(define SHIP2 (make-spaceship
               (make-posn 24 650)
               LEFT
               2))
(define NEW-SHIP2 (make-spaceship
               (make-posn (/ SHIP-WIDTH 2) 650)
               LEFT
               2))
(define SHIP3 (make-spaceship
               (make-posn 300 650)
               RIGHT
               2))
(define NEW-SHIP3 (make-spaceship
               (make-posn (+ 300 SHIP-SPEED) 650)
               RIGHT
               2))
(define SHIP4 (make-spaceship
               (make-posn 476 650)
               RIGHT
               2))
(define NEW-SHIP4 (make-spaceship
               (make-posn (- WIDTH (/ SHIP-WIDTH 2)) 650)
               RIGHT
               2))
(define SHIP5 (make-spaceship
               (make-posn 476 650)
               LEFT
               2))

;;;; Signature
;; move-spaceship: Spaceship -> Spaceship
;;;; Purpose
;; GIVEN: a spaceship
;; RETURNS: a new spaceship that has moved by SHIP-SPEED units
;;;; Function Definition
(define (move-spaceship ship)
  (cond
    [(symbol=? (spaceship-dir ship) LEFT)
     (move-spaceship-left ship)]
    [(symbol=? (spaceship-dir ship) RIGHT)
     (move-spaceship-right ship)]))
;;;; Tests
(check-expect (move-spaceship SHIP1) NEW-SHIP1)
(check-expect (move-spaceship SHIP2) NEW-SHIP2)
(check-expect (move-spaceship SHIP3) NEW-SHIP3)
(check-expect (move-spaceship SHIP4) NEW-SHIP4)


;;;; Signature
;; move-spaceship-left: Spaceship -> Spaceship
;;;; Purpose
;; GIVEN: a spaceship
;; RETURNS: a new spaceship that has moved left by SHIP-SPEED units
;;;; Function Definition
(define (move-spaceship-left ship)
  (if (< (- (posn-x (spaceship-loc ship)) (/ SHIP-WIDTH 2)) SHIP-SPEED)
     (make-spaceship 
     (make-posn (/ SHIP-WIDTH 2)
                (posn-y (spaceship-loc ship)))
     (spaceship-dir ship)
     (spaceship-lives ship))
     (make-spaceship 
     (make-posn (- (posn-x (spaceship-loc ship)) SHIP-SPEED)
                (posn-y (spaceship-loc ship)))
     (spaceship-dir ship)
     (spaceship-lives ship))))
;;;; Tests
(check-expect (move-spaceship-left SHIP1) NEW-SHIP1)
(check-expect (move-spaceship-left SHIP2) NEW-SHIP2)


;;;; Signature
;; move-spaceship-right: Spaceship -> Spaceship
;;;; Purpose
;; GIVEN: a spaceship
;; RETURNS: a new spaceship that has moved right by SHIP-SPEED units
;;;; Function Definition
(define (move-spaceship-right ship)
  (if
   (> (+ (posn-x (spaceship-loc ship)) (/ SHIP-WIDTH 2)) (- WIDTH SHIP-SPEED))
     (make-spaceship 
     (make-posn (- WIDTH (/ SHIP-WIDTH 2))
                (posn-y (spaceship-loc ship)))
     (spaceship-dir ship)
     (spaceship-lives ship))
     (make-spaceship 
     (make-posn (+ (posn-x (spaceship-loc ship)) SHIP-SPEED)
                (posn-y (spaceship-loc ship)))
     (spaceship-dir ship)
     (spaceship-lives ship))))
;;;; Tests
(check-expect (move-spaceship-right SHIP3) NEW-SHIP3)
(check-expect (move-spaceship-right SHIP4) NEW-SHIP4)


;;;; Signature
;; change-ship-direction: Spaceship -> Spaceship
;;;; Purpose
;; GIVEN: a spaceship
;; RETURNS: a new spaceship with its direction changed
;;;; Function Definition
(define (change-ship-direction ship)
  (cond
    [(symbol=? (spaceship-dir ship) LEFT)
     (make-spaceship (spaceship-loc ship)
                     RIGHT
                     (spaceship-lives ship))]
    [else
     (make-spaceship (spaceship-loc ship)
                     LEFT
                     (spaceship-lives ship))]))
;;;; Tests
(check-expect (change-ship-direction SHIP1) SHIP3)
(check-expect (change-ship-direction SHIP4) SHIP5)

    
;;;;------------------MOVE INVADERS--------------------------

(define INVA1 (make-posn 170 90))
(define NEW-INVA1 (make-posn 170 (+ 90 INVADER-SPEED)))
(define INVA2 (make-posn 210 120))
(define NEW-INVA2 (make-posn 210 (+ 120 INVADER-SPEED)))
(define INVA3 (make-posn 250 150))
(define NEW-INVA3 (make-posn 250 (+ 150 INVADER-SPEED)))
(define LOI1 (list INVA1 INVA2 INVA3))
(define NEW-LOI1 (list NEW-INVA1 NEW-INVA2 NEW-INVA3))
(define INVADERS1 (make-invaders LOI1 ZERO))
(define NEW-INVADERS1 (make-invaders NEW-LOI1 TICKS))
(define INVADERS2 (make-invaders LOI1 TICKS))
(define NEW-INVADERS2 (make-invaders LOI1 (- TICKS ONE)))


;;;; Signature
;; move-invader: Invader -> Invader
;;;; Purpose
;; GIVEN: an invader
;; RETURNS: a new invader which has moved down by INVADER-SPEED units
;;;; Function Definition
(define (move-invader invader)
  (make-posn (posn-x invader)
             (+ (posn-y invader) INVADER-SPEED)))
;;;; Tests
(check-expect (move-invader INVA1) NEW-INVA1) 
(check-expect (move-invader INVA2) NEW-INVA2)


;;;; Signature
;; move-loi: LoI -> LoI
;;;; Purpose
;; GIVEN: a list of invaders
;; RETURNS: a new list of invaders which has moved down by INVADER-SPEED units
;;;; Function Definition
(define (move-loi loi)
  (cond
    [(empty? loi) loi]
    [(cons? loi) (cons (move-invader (first loi))
                       (move-loi (rest loi)))]))
;;;; Tests
(check-expect (move-loi MTLOP) MTLOP)
(check-expect (move-loi LOI1) NEW-LOI1) 


;;;; Signature
;; move-invaders: Invaders -> Invaders
;;;; Purpose
;; GIVEN: an invaders
;; RETURNS: if the invaders' tick is ZERO, move all the list of invaders down
;;          by INVADER-SPEED, otherwise tick minus ONE; return the new invaders
;;;; Function Definition
(define (move-invaders invaders)
  (cond
    [(= ZERO (invaders-ticks invaders))
     (make-invaders (move-loi (invaders-loi invaders)) TICKS)]
    [else (make-invaders (invaders-loi invaders)
                         (- (invaders-ticks invaders) ONE))]))
;;;; Tests
(check-expect (move-invaders INVADERS1) NEW-INVADERS1)
(check-expect (move-invaders INVADERS2) NEW-INVADERS2)
              


;;;;----------------MOVE SPACESHIP BULLETS-----------------


(define SBULLET1 (make-posn 600 400))
(define NEW-SBULLET1 (make-posn 600 (- 400 S-BULLET-SPEED)))
(define SBULLET2 (make-posn 400 300))
(define NEW-SBULLET2 (make-posn 400 (- 300 S-BULLET-SPEED)))
(define SBULLET3 (make-posn 200 200))
(define NEW-SBULLET3 (make-posn 200 (- 200 S-BULLET-SPEED)))
(define LOB1 (list SBULLET1 SBULLET2 SBULLET3))
(define NEW-LOB1 (list NEW-SBULLET1 NEW-SBULLET2 NEW-SBULLET3))

;;;; Signature
;; move-spaceship-bullets: LoB -> LoB
;;;; Purpose
;; GIVEN: a list of spaceship bullets
;; RETURNS: a new list of bullets which has moved up by BULLET-SPEED units
;;;; Function Definition
(define (move-spaceship-bullets lob)
  (cond
    [(empty? lob) lob]
    [(cons? lob) (cons (move-bullet-up (first lob))
                       (move-spaceship-bullets (rest lob)))]))
;;;; Tests
(check-expect (move-spaceship-bullets MTLOP) MTLOP)
(check-expect (move-spaceship-bullets LOB1) NEW-LOB1)


;;;; Signature
;; move-bullet-up: Bullet -> Bullet
;;;; Purpose
;; GIVEN: a bullet
;; RETURNS: a new bullet which has moved up by BULLET-SPEED units
;;;; Function Definition
(define (move-bullet-up bullet)
  (make-posn (posn-x bullet)
             (- (posn-y bullet) S-BULLET-SPEED)))
;;;; Tests
(check-expect (move-bullet-up SBULLET1) NEW-SBULLET1)
(check-expect (move-bullet-up SBULLET2) NEW-SBULLET2)
(check-expect (move-bullet-up SBULLET3) NEW-SBULLET3)


;;;;-----------------MOVE INVADER BULLETS-------------------


(define IBULLET1 (make-posn 150 200))
(define NEW-IBULLET1 (make-posn 150 (+ 200 I-BULLET-SPEED)))
(define IBULLET2 (make-posn 250 400))
(define NEW-IBULLET2 (make-posn 250 (+ 400 I-BULLET-SPEED)))
(define IBULLET3 (make-posn 400 500))
(define NEW-IBULLET3 (make-posn 400 (+ 500 I-BULLET-SPEED)))
(define LOB2 (list IBULLET1 IBULLET2 IBULLET3))
(define NEW-LOB2 (list NEW-IBULLET1 NEW-IBULLET2 NEW-IBULLET3))

;;;; Signature
;; move-invader-bullets: LoB -> LoB
;;;; Purpose
;; GIVEN: a list of invader bullets
;; RETURNS: a new list of bullets which has moved down by BULLET-SPEED units
;;;; Function Definition
(define (move-invader-bullets lob)
  (cond
    [(empty? lob) lob]
    [(cons? lob) (cons (move-bullet-down (first lob))
                       (move-invader-bullets (rest lob)))]))
;;;; Tests
(check-expect (move-invader-bullets MTLOP) MTLOP)
(check-expect (move-invader-bullets LOB2) NEW-LOB2)

;;;; Signature
;; move-bullet-down: Bullet -> Bullet
;;;; Purpose
;; GIVEN: a bullet
;; RETURNS: a new bullet which has moved down by I-BULLET-SPEED units
;;;; Function Definition
(define (move-bullet-down bullet)
  (make-posn (posn-x bullet)
             (+ (posn-y bullet) I-BULLET-SPEED)))
;;;; Tests
(check-expect (move-bullet-down IBULLET1) NEW-IBULLET1)
(check-expect (move-bullet-down IBULLET2) NEW-IBULLET2)
(check-expect (move-bullet-down IBULLET3) NEW-IBULLET3)


;;;;-----------------SPACESHIP FIRE-------------------

(define WORLD-TEST2 (make-world
                    SPACESHIP-TEST
                    INVADERS-TEST
                    LOB1
                    I-BULLETS-TEST
                    SCORE-TEST))
(define NEW-WORLD-TEST1 (make-world
                    SPACESHIP-TEST
                    INVADERS-TEST
                    (cons (spaceship-loc SPACESHIP-TEST) S-BULLETS-TEST)
                    I-BULLETS-TEST
                    SCORE-TEST))


;;;; Signature
;; elements-number: LoB|LoI -> NonNegInteger
;;;; Purpose
;; GIVEN: a list of bullets or a list of invaders
;; RETURNS: the number of elements in the given list
;;;; Function Definition
(define (elements-number list)
  (cond
    [(empty? list) ZERO]
    [(cons? list) (+ ONE (elements-number (rest list)))]))
;;;; Tests
(check-expect (elements-number MTLOP) ZERO)
(check-expect (elements-number LOB1) THREE)


;;;; Signature
;; spaceship-fire: World -> World
;;;; Purpose
;; GIVEN: a world
;; RETURNS: if the MAX-SHIP-BULLETS number of bullets has been fired,
;;          return the original world, otherwise fire one bullet and
;;          return the updated world
;;;; Function Definition
(define (spaceship-fire world)
  (cond
    [(= (elements-number (world-ship-bullets world)) MAX-SHIP-BULLETS)
     world]
    [else (make-world (world-spaceship world)
                      (world-invaders world)
                      (cons (spaceship-loc (world-spaceship world))
                            (world-ship-bullets world))
                      (world-invader-bullets world)
                      (world-score world))]))
;;;; Tests
(check-expect (spaceship-fire WORLD-TEST1) NEW-WORLD-TEST1)
(check-expect (spaceship-fire WORLD-TEST2) WORLD-TEST2)


;;;;-----------------INVADERS FIRE-------------------

(define LOB3 (list (make-posn 90 90) (make-posn 90 130) (make-posn 90 170)
                   (make-posn 120 210) (make-posn 120 250) (make-posn 120 290)
                   (make-posn 150 330) (make-posn 150 370) (make-posn 150 410)
                   (make-posn 180 410)))
(define LOB4 (list (make-posn 90 130) (make-posn 90 170)
                   (make-posn 120 210) (make-posn 120 250) (make-posn 120 290)
                   (make-posn 150 330) (make-posn 150 370)
                   (make-posn 150 410) (make-posn 180 410)))


;;;; Signature
;; find-element: LoB|LoI NonNegInteger -> Bullet|Invadar
;;;; Purpose
;; GIVEN: a list of bullets or a list of invaders and an index
;; RETURNS: the element(bullet or invader) at the given index
;; WHERE: the given index is in the range [ZERO (elements-number list)]
;;;; Function Definition
(define (find-element list index)
  (cond
    [(empty? list) empty]
    [(= ONE index) (first list)]
    [else (find-element (rest list) (- index ONE))]))
;;;; Tests
(check-expect (find-element MTLOP ZERO) empty)
(check-expect (find-element LOB1 TWO) SBULLET2)
(check-expect (find-element LOB2 ONE) IBULLET1)

;;;; Signature
;; invaders-fire: LoB LoI -> LoB
;; Purpose
;; GIVEN: a list of bullets and a list of invaders
;; RETURNS: a new list of bullets with a new bullets fired by a random invader
;;;; Function Definition 
(define (invaders-fire lob loi)
  (cond
    [(empty? loi) lob]
    [(>= (elements-number lob) MAX-INVADER-BULLETS) lob]
    [else (make-new-lob lob loi (+ ONE (random (elements-number loi))))]))
;;;; Tests
(check-expect (invaders-fire LOB2 MTLOP) LOB2) 
(check-expect (invaders-fire LOB3 LOI-INIT) LOB3) 
(check-random (invaders-fire LOB4 LOI-INIT)
              (make-new-lob LOB4 LOI-INIT (+ ONE (random INVADER-NUM))))

               
;;;; Signature
;; make-new-lob: LoB LoI PosInteger -> LoB
;; Purpose
;; GIVEN: a list of bullets, a list of invaders and a index
;; RETURNS: a new list of bullets with the index of elements' position
;;         in the list of invaders added in
;; WHERE: the index is in the range [ONE (elements-number loi)]
;;;; Function Definition
(define (make-new-lob lob loi index)
  (cond
    [(empty? loi) lob]
    [else (cons (find-element loi index) lob)]))
;;;; Tests
(check-expect (make-new-lob LOB2 MTLOP ONE) LOB2)
(check-expect (make-new-lob LOB4 LOI-INIT ONE) LOB3)

;;;;-----------------UPDATE INVADERS-------------------

(define SBULLET4 (make-posn 250 250))
(define INVA4 (make-posn 250 235))
(define INVA5 (make-posn 250 234))
(define LOB5 (list SBULLET1 SBULLET2 SBULLET3 SBULLET4))
(define LOI2 (list INVA1 INVA2 INVA4 INVA3))
(define INVADERS3 (make-invaders MTLOP TICKS))
(define INVADERS4 (make-invaders LOI2 TICKS))

;;;; Signature 
;; bullet-hit-invader? Bullet Invader -> Boolean
;;;; Purpose
;; GIVEN: a spaceship bullet and an invader
;; RETURNS: true if the bullet hit the invader, false otherwise
;;;; Function Definition
(define (bullet-hit-invader? bullet invader)
  (and (<= (abs (- (posn-x bullet) (posn-x invader)))
           (+ BULLET-RADIUS (/ INVADER-SIDE 2)))
       (<= (abs (- (posn-y bullet) (posn-y invader)))
           (+ BULLET-RADIUS (/ INVADER-SIDE 2)))))
;;;; Tests
(check-expect (bullet-hit-invader? SBULLET4 INVA4) #true)
(check-expect (bullet-hit-invader? SBULLET4 INVA5) #false)


;;;; Signature
;; lob-hit-invader? LoB Invader -> Boolean
;;;; Purpose
;; GIVEN: a list of spaceship bullets and an invader
;; RETURNS: true if one of the list of bullets hit the invader,
;; and false otherwise
;;;; Function Definition
(define (lob-hit-invader? lob invader)
  (cond
    [(empty? lob) #false]
    [(cons? lob) (or (bullet-hit-invader? (first lob) invader)
                     (lob-hit-invader? (rest lob) invader))]))
;;;; Tests
(check-expect (lob-hit-invader? MTLOP INVA4) #false)
(check-expect (lob-hit-invader? LOB5 INVA4) #true)


;;;; Signature
;; remove-hit-invaders: LoI LoB -> LoI
;;;; Purpose
;; GIVEN: a list of invaders and a list of spaceship bullets
;; RETURNS: a new list of invaders with the hit invaders
;;         removed from the original list
;;;; Function Definition
(define (remove-hit-invaders loi lob)
  (cond
    [(empty? loi) loi]
    [(cons? loi)
     (if (lob-hit-invader? lob (first loi))
         (remove-hit-invaders (rest loi) lob)
         (cons (first loi) (remove-hit-invaders (rest loi) lob)))]))
;;;; Tests
(check-expect (remove-hit-invaders MTLOP LOB5) MTLOP)
(check-expect (remove-hit-invaders LOI2 LOB5) LOI1)


;;;; Signature
;; update-invaders: Invaders LoB -> Invaders
;;;; Purpose
;; GIVEN: an invaders and a list of spaceship bullets
;; RETURNS: a new invaders with all the hit invader removed
;;;; Function Definition
(define (update-invaders invaders lob)
  (make-invaders (remove-hit-invaders (invaders-loi invaders) lob)
                 (invaders-ticks invaders)))
;;;; Tests
(check-expect (update-invaders INVADERS3 LOB5) INVADERS3)
(check-expect (update-invaders INVADERS4 LOB5) INVADERS2)
      
;;;;-----------------UPDATE SPEACHSHIP BULLETS-------------------

(define BULLET1 (make-posn -1 200))
(define BULLET2 (make-posn 100 -1))
(define BULLET3 (make-posn 501 350))
(define BULLET4 (make-posn 100 701))
(define BULLET5 (make-posn 170 270))
(define BULLET6 (make-posn 250 235))
(define BULLET7 (make-posn 368 479))
(define LOB6 (list BULLET1 BULLET5 BULLET2 BULLET3 BULLET6 BULLET7 BULLET4))
(define NEW-LOB6 (list BULLET5 BULLET6 BULLET7))

(define BULLET8 (make-posn 400 500))
(define BULLET9 (make-posn 434 512))
(define INVA6 (make-posn 170 270))
(define INVA7 (make-posn 434 512)) 
(define INVA8 (make-posn 400 500))
(define LOI3 (list INVA1 INVA2 INVA3 INVA4 INVA5 INVA6 INVA7 INVA8))
(define LOB7 (list BULLET5 BULLET6 BULLET7 BULLET8 BULLET9))
(define NEW-LOB7 (list BULLET7))
(define LOB8 (list BULLET5 BULLET6 BULLET6 BULLET7 BULLET8 BULLET8))
(define NEW-LOB8 (list BULLET6 BULLET7 BULLET8))
(define LOB9 (cons BULLET1
                   (cons BULLET2
                                 (cons BULLET3
                                       (cons BULLET4 LOB7)))))
(define LOB10 (cons BULLET1
                    (cons BULLET2
                                  (cons BULLET3
                                        (cons BULLET4 LOB8)))))

;;;; Signature
;; out-of-bound?: Bullet -> Boolean
;;;; Purpose
;; GIVEN: a bullet
;; RETURNS: true if the bullet is out of bound, and false otherwise
;;;; Function Definition
(define (out-of-bound? bullet)
  (not (and (<= ZERO (posn-x bullet) WIDTH)
            (<= ZERO (posn-y bullet) HEIGHT))))
;;;; Tests
(check-expect (out-of-bound? BULLET1) #true)
(check-expect (out-of-bound? BULLET2) #true)
(check-expect (out-of-bound? BULLET3) #true)
(check-expect (out-of-bound? BULLET4) #true)
(check-expect (out-of-bound? BULLET5) #false)
(check-expect (out-of-bound? BULLET6) #false)
(check-expect (out-of-bound? BULLET7) #false)


;;;; Signature
;; remove-out-of-bound: LoB -> LoB
;;;; Purpose
;; GIVEN: a list of bullets
;; RETURNS: a new list of bullets with the out of bound bullet removed
;;;; Function Definition
(define (remove-out-of-bound lob)
  (cond
    [(empty? lob) lob]
    [(cons? lob) (if (out-of-bound? (first lob))
                     (remove-out-of-bound (rest lob))
                     (cons (first lob) (remove-out-of-bound (rest lob))))]))
;;;; Tests
(check-expect (remove-out-of-bound MTLOP) MTLOP)
(check-expect (remove-out-of-bound LOB6) NEW-LOB6)


;;;; Signature
;; bullet-hit-loi? Bullet LoI -> Boolean
;;;; Purpose
;; GIVEN: a spaceship bullet and a list of invaders
;; RETURNS: true if the bullet hit the invader in the list, false otherwise
;;;; Function Definition
(define (bullet-hit-loi? bullet loi)
  (cond
    [(empty? loi) #false]
    [(cons? loi) (or (bullet-hit-invader? bullet (first loi))
                     (bullet-hit-loi? bullet (rest loi)))]))
;;;; Tests
(check-expect (bullet-hit-loi? BULLET6 MTLOP) #false)
(check-expect (bullet-hit-loi? BULLET6 LOI2) #true)
(check-expect (bullet-hit-loi? BULLET7 LOI2) #false)


;;;; Signature
;; remove-hit-invader: Bullet LoI -> LoI
;;;; Purpose
;; GIVEN: a spaceship bullet and a list of invaders
;; RETURNS: if the bullet hit one invader, return the new list of invaders
;;          with the hit invader removed, otherwise return the original
;;          list of invaders
;;;; Function Definition
(define (remove-hit-invader bullet loi)
  (cond
    [(empty? loi) loi]
    [(cons? loi)
     (if (bullet-hit-invader? bullet (first loi))
         (remove-hit-invader bullet (rest loi))
         (cons (first loi) (remove-hit-invader bullet (rest loi))))]))
;;;; Tests
(check-expect (remove-hit-invader BULLET6 MTLOP) MTLOP)
(check-expect (remove-hit-invader BULLET6 LOI2) LOI1)

;;;; Signature
;; remove-used-spaceship-bullets: LoB LoI -> LoB
;;;; Purpose
;; GIVEN: a list of spaceship bullets and a list of invaders
;; RETURNS: a new list of spaceship bullets with the used bullets
;;         removed from the original list
;;;; Function Definition
(define (remove-used-spaceship-bullets lob loi)
  (cond
    [(empty? lob) lob]
    [(cons? lob) (if (bullet-hit-loi? (first lob) loi)
                     (remove-used-spaceship-bullets (rest lob)
                      (remove-hit-invader (first lob) loi))
                     (cons (first lob)
                           (remove-used-spaceship-bullets (rest lob) loi)))]))
;;;; Tests
(check-expect (remove-used-spaceship-bullets MTLOP LOI2) MTLOP)
(check-expect (remove-used-spaceship-bullets LOB7 LOI3) NEW-LOB7)                       
(check-expect (remove-used-spaceship-bullets LOB8 LOI3) NEW-LOB8)   

;;;; Signature
;; update-spaceship-bullets: LoB LoI -> LoB
;;;; Purpose
;; GIVEN: a list of spaceship bullets and a list of Invaders
;; RETURNS: a new list of spaceship bullets with the out-of-bound bullets
;;          and used bullets removed
;;;; Function Definition
(define (update-spaceship-bullets lob loi)
  (remove-out-of-bound (remove-used-spaceship-bullets lob loi)))
;;;; Tests
(check-expect (update-spaceship-bullets LOB9 LOI3) NEW-LOB7)
(check-expect (update-spaceship-bullets LOB10 LOI3) NEW-LOB8)


;;;;-----------------UPDATE INVADER BULLETS-------------------

(define IBULLET4 (make-posn 280 637.5))
(define IBULLET5 (make-posn 310 643))
(define LOB11 (list IBULLET4 IBULLET1  IBULLET5))
(define NEW-LOB11 (list IBULLET1))
(define IBULLET6 (make-posn 170 701))
(define LOB12 (list IBULLET6 IBULLET5 IBULLET1 IBULLET4))
(define LOIB1 (list (make-posn 290 640) (make-posn 170 500)
                    (make-posn 250 400)))
(define NEW-LOIB1 (list (make-posn 170 500) (make-posn 250 400)))

;;;; Signature
;; bullet-hit-spaceship? Bullet Spaceship -> Boolean
;;;; Purpose
;; GIVEN: an invader bullet and a spaceship
;; RETURNS: true if the invader bullet hit the spaceship, false otherwise
;;;; Function Definition
(define (bullet-hit-spaceship? bullet spaceship)
  (and (<= (abs (- (posn-x bullet) (posn-x (spaceship-loc spaceship))))
           (+ BULLET-RADIUS (/ SHIP-WIDTH 2)))
       (<= (abs (- (posn-y bullet) (posn-y (spaceship-loc spaceship))))
           (+ BULLET-RADIUS (/ SHIP-HEIGHT 2)))))
;;;; Tests
(check-expect (bullet-hit-spaceship? IBULLET1 SHIP1) #false)
(check-expect (bullet-hit-spaceship? IBULLET4 SHIP1) #true)  
(check-expect (bullet-hit-spaceship? IBULLET5 SHIP1) #true)


;;;; Signature
;; remove-used-invader-bullets: LoB Spaceship -> LoB
;;;; Purpose
;; GIVEN: a list of invader bullets and a spaceship
;; RETURNS: a new list of invader bullets with the used bullets
;;         removed from the original list
;;;; Function Definition
(define (remove-used-invader-bullets lob spaceship)
  (cond
    [(empty? lob) lob]
    [(cons? lob)
     (if (bullet-hit-spaceship? (first lob) spaceship)
         (remove-used-invader-bullets (rest lob) spaceship)
         (cons (first lob)
               (remove-used-invader-bullets (rest lob) spaceship)))]))
;;;; Tests
(check-expect (remove-used-invader-bullets MTLOP SHIP1) MTLOP)
(check-expect (remove-used-invader-bullets LOB11 SHIP1) NEW-LOB11)  

 
;;;; Signature
;; update-invader-bullets: LoB Spaceship -> LoB
;;;; Purpose
;; GIVEN: a list of invader bullets and a spaceship
;; RETURNS: a new list of invader bullets with the out-of-bound bullets
;;          and used bullets removed
;;;; Function Definition
(define (update-invader-bullets lob spaceship)
  (remove-out-of-bound (remove-used-invader-bullets lob spaceship)))
;;;; Tests
(check-expect (update-invader-bullets LOB11 SHIP1) NEW-LOB11)
(check-expect (update-invader-bullets LOB12 SHIP1) NEW-LOB11)
(check-expect (update-invader-bullets LOIB1 SHIP1) NEW-LOIB1)


;;;;-----------------REMOVE HITS AND OUT OF BOUNDS----------------


(define SBULLET5 (make-posn 210 120))
(define SBULLET6 (make-posn -2  300))
(define SBULLET7 (make-posn 300 600))
(define LOSB1 (list SBULLET5 SBULLET6 SBULLET7))
(define NEW-LOSB1 (list SBULLET7))
(define INVADERS5 (make-invaders LOI3 TICKS))
(define NEW-LOI3 (list INVA1 INVA3 INVA4 INVA5 INVA6 INVA7 INVA8))
(define NEW-INVADERS5 (make-invaders NEW-LOI3 TICKS))

(define WORLD-TEST3 (make-world
                    SHIP1
                    INVADERS5
                    LOSB1
                    LOIB1
                    SCORE-TEST))
(define NEW-WORLD-TEST3 (make-world
                    SHIP1
                    NEW-INVADERS5
                    NEW-LOSB1
                    NEW-LOIB1
                    SCORE-TEST))


;;;; Signature
;; remove-hits-and-out-of-bounds: World -> World
;;;; Purpose
;; GIVEN: a world
;; RETURNS: a new world with all hit invaders
;;          and all used and out-of-bound bullets removed
;;;; Function Definition
(define (remove-hits-and-out-of-bounds w)
  (make-world (world-spaceship w)
              (update-invaders (world-invaders w) (world-ship-bullets w))
              (update-spaceship-bullets (world-ship-bullets w)
                                        (invaders-loi (world-invaders w)))
              (update-invader-bullets (world-invader-bullets w)
                                      (world-spaceship w))
              (world-score w)))
;;;; Test
(check-expect (remove-hits-and-out-of-bounds WORLD-INIT) WORLD-INIT)
(check-expect (remove-hits-and-out-of-bounds WORLD-TEST3) NEW-WORLD-TEST3)


;;;;-----------------UPDATE REMAINING LIVES-----------------------

(define WORLD-TEST4 (make-world
                    (make-spaceship SHIP-INIT-POSN
                                    (spaceship-dir SHIP1)
                                    ONE)
                    INVADERS5
                    LOSB1
                    LOIB1
                    SCORE-TEST))

(define WORLD-TEST5 (make-world
                    SHIP1
                    INVADERS5
                    LOSB1
                    NEW-LOIB1
                    SCORE-TEST))

;;;; Signature
;; ship-hit? Spaceship LoB -> Boolean
;;;; Purpose
;; GIVEN: a spaceship and a list of invader bullets
;; RETURNS: true if the spaceship has been hit and false otherwise
;;;; Function Definition
(define (ship-hit? ship lob)
  (cond
    [(empty? lob) #false]
    [(cons? lob) (or (bullet-hit-spaceship? (first lob) ship)
                     (ship-hit? ship (rest lob)))]))
;;;; Tests
(check-expect (ship-hit? SHIP1 MTLOP) #false)
(check-expect (ship-hit? SHIP1 LOIB1) #true)
(check-expect (ship-hit? SHIP1 NEW-LOIB1) #false)


;;;; Signature
;; update-lives: World -> World
;;;; Purpose
;; GIVEN: a world
;; RETURNS: if the spaceship in the world is hit by the invader bullets
;;          in the world, return the new world with the new spaceship
;;          with its lives minus ONE, Otherwise return the original world
;;;; Function Definition
(define (update-lives w)
  (if (ship-hit? (world-spaceship w)
                 (world-invader-bullets w))
      (make-world (make-spaceship SHIP-INIT-POSN
                         (spaceship-dir (world-spaceship w))
                         (- (spaceship-lives (world-spaceship w)) ONE))
                  (world-invaders w)
                  (world-ship-bullets w)
                  (world-invader-bullets w)
                  (world-score w))
      w))
;;;; Tests
(check-expect (update-lives WORLD-TEST3) WORLD-TEST4)
(check-expect (update-lives WORLD-TEST5) WORLD-TEST5)


;;;;-----------------UPDATE SCORE-----------------------

(define WORLD-TEST6 (make-world
                    SHIP1
                    INVADERS5
                    LOSB1
                    LOIB1
                    (+ SCORE-TEST POINTS-PER-HIT)))

;;;; Signature
;; count-score: NonNegInteger LoI LoB -> NonNegInteger 
;;;; Purpose
;; GIVEN: a current score, a list of invaders and a list of spaceship bullets
;; RETURNS: add POINTS-PER-HIT every time a bullet hit an invader
;;          and return the new score, otherwise return the original score
;;;; Function Definition
(define (count-score score loi lob)
  (cond
    [(empty? loi) score]
    [(empty? lob) score]
    [(cons? lob)(if (bullet-hit-loi? (first lob) loi)
                    (+ POINTS-PER-HIT
                    (count-score score
                    (remove-hit-invader (first lob) loi)
                    (rest lob)))
                    (count-score score loi (rest lob)))]))
;;;; Tests
(check-expect (count-score SCORE-TEST MTLOP LOSB1) SCORE-TEST)
(check-expect (count-score SCORE-TEST LOI3 MTLOP) SCORE-TEST)
(check-expect (count-score SCORE-TEST LOI3 LOSB1)
              (+ SCORE-TEST POINTS-PER-HIT))
(check-expect (count-score SCORE-TEST NEW-LOI3 LOSB1) SCORE-TEST)


;;;; Signature
;; undate-score: World -> World
;;;; Purpose
;; GIVEN: a world
;; RETURNS: a new world with the updated score if any invaders has been hit,
;;         otherwise return the original world
;;;; Function Definition
(define (update-score w)
  (make-world (world-spaceship w)
              (world-invaders w)
              (world-ship-bullets w)
              (world-invader-bullets w)
              (count-score (world-score w)
                                   (invaders-loi (world-invaders w))
                                   (world-ship-bullets w))))
;;;; Tests
(check-expect (update-score WORLD-TEST3) WORLD-TEST6)
(check-expect (update-score NEW-WORLD-TEST3) NEW-WORLD-TEST3)


;;;;-----------------UPDATE WORLD-----------------------


;;;; Signature
;; world-step: World -> World
;;;; Purpose
;; GIVEN: a world
;; RETURNS: a new world after unit tick
;;;; Function Definition
(define (world-step world)
  (remove-hits-and-out-of-bounds
   (update-score
   (update-lives
     (make-world (move-spaceship (world-spaceship world))
                 (move-invaders (world-invaders world))
                 (move-spaceship-bullets (world-ship-bullets world))
                 (invaders-fire
                  (move-invader-bullets (world-invader-bullets world))
                  (invaders-loi (world-invaders world)))
                 (world-score world))))))
;;;; Tests
(check-random (world-step WORLD-INIT)
              (make-world (make-spaceship
                           (make-posn (+ SHIP-POSNX SHIP-SPEED) SHIP-POSNY)
                           RIGHT
                           MAX-LIVES)
                          (make-invaders LOI-INIT (- TICKS ONE))
                          empty
                          (list (find-element LOI-INIT
                                   (+ ONE (random INVADER-NUM))))
                          ZERO))
(check-random (world-step WORLD-TEST3)
              (make-world (make-spaceship
                           SHIP-INIT-POSN
                           LEFT
                           ONE)
                          (make-invaders LOI3 (- TICKS ONE))
                          (list (make-posn 210 (- 120 S-BULLET-SPEED))
                                (make-posn 300 (- 600 S-BULLET-SPEED)))
                          (list (find-element LOI3
                                   (+ ONE (random 8)))
                                (make-posn 290 (+ 640 I-BULLET-SPEED))
                                (make-posn 170 (+ 500 I-BULLET-SPEED))
                                (make-posn 250 (+ 400 I-BULLET-SPEED)))
                          SCORE-TEST))                                   

               
;;;;-----------------KEY HANDLER-----------------------


;;;; Signature 
;; key-handler : World Key-Event -> World
;;;; Purpose
;; GIVEN: the current world and a key event
;; RETURNS: if the key-event is space, make spaceship to fire a bullet;
;;          if the key-event is left or right, change spaceship direction
;;          as the key-event
;;;; Function Definition
(define (key-handler world key-event)
  (cond 
    [(key=? key-event " ") (spaceship-fire world)]
    [(or (key=? key-event "left")
         (key=? key-event "right"))
     (make-world (make-spaceship
                  (spaceship-loc (world-spaceship world))
                  (string->symbol key-event)
                  (spaceship-lives (world-spaceship world)))
                 (world-invaders world)
                 (world-ship-bullets world)
                 (world-invader-bullets world)
                 (world-score world))]
    [else world]))
;;;; Tests
(check-expect (key-handler WORLD-INIT "up") WORLD-INIT)
(check-expect (key-handler WORLD-INIT " ")
              (make-world SPACESHIP-INIT
                          INVADERS-INIT
                          (list SHIP-INIT-POSN)
                          empty
                          ZERO))
(check-expect (key-handler WORLD-INIT "left")
              (make-world (make-spaceship SHIP-INIT-POSN
                                          LEFT
                                          MAX-LIVES) 
                          INVADERS-INIT
                          empty
                          empty
                          ZERO))
(check-expect (key-handler WORLD-INIT "right") WORLD-INIT)
             

;;;;-----------------END GAME CNODITIONS---------------------

(define WORLD-TEST7 (make-world
                     (make-spaceship SHIP-INIT-POSN
                                     RIGHT
                                     ZERO)
                     INVADERS-INIT
                     LOSB1
                     LOIB1
                     SCORE-TEST))
(define WORLD-TEST8 (make-world
                     SPACESHIP-INIT
                    (make-invaders MTLOP TICKS)
                     LOSB1
                     LOIB1
                     SCORE-TEST))
(define WORLD-TEST9 (make-world
                     SPACESHIP-INIT
                     (make-invaders
                      (list (make-posn 400 SHIP-POSNY))
                      TICKS)
                     LOSB1
                     LOIB1
                     SCORE-TEST))

;;;; Signature 
;; end-game? : World -> Boolean
;;;; Purpose 
;; GIVEN: the current world
;; RETURNS: true if one of the condition that end the game has been met,
;;          false otherwise
;;;; Function Definition
(define (end-game? world)
  (or (lost-all-lives? world)
      (killed-all-invaders? world)
      (invaders-reached-bottom? (invaders-loi (world-invaders world)))))
;;;; Tests
(check-expect (end-game? WORLD-INIT) #false)
(check-expect (end-game? WORLD-TEST7) #true)
(check-expect (end-game? WORLD-TEST8) #true)
(check-expect (end-game? WORLD-TEST9) #true)


;;;; Signature 
;; lost-all-lives? : World -> Boolean
;;;; Purpose
;; GIVEN: a world
;; RETURNS: true if the spaceship's lives is below ZERO,
;;          and false otherwise
;;;; Function Definition
(define (lost-all-lives? world)
  (<= (spaceship-lives (world-spaceship world)) ZERO))
;;;; Tests
(check-expect (lost-all-lives? WORLD-TEST7) #true)
(check-expect (lost-all-lives? WORLD-INIT) #false)


;;;; Signature 
;; killed-all-invaders? : World -> Boolean
;;;; Purpose 
;; GIVEN: a world
;; RETURNS: true if all the invaders have been killed,
;;          and false otherwise
;;;; Function Definition
(define (killed-all-invaders? world)
  (= (elements-number (invaders-loi (world-invaders world))) ZERO))
;;;; Tests
(check-expect (killed-all-invaders? WORLD-TEST8) #true)
(check-expect (killed-all-invaders? WORLD-INIT) #false)


;;;; Signature 
;; invaders-reached-bottom? : LoI -> Boolean
;;;; Purpose 
;; GIVEN: a list of invaders
;; RETURNS: true if there is at least one invader has reached
;;          the same y-coordinate as the spaceship, and false otherwise
;;;; Function Definition
(define (invaders-reached-bottom? loi)
  (cond
    [(empty? loi) #false]
    [(cons? loi) (or (>= (posn-y (first loi)) SHIP-POSNY)
                     (invaders-reached-bottom? (rest loi)))]))

;;;; Tests
(check-expect (invaders-reached-bottom?
               (invaders-loi (world-invaders WORLD-TEST9))) #true)
(check-expect (invaders-reached-bottom?
               (invaders-loi (world-invaders WORLD-TEST8))) #false)
(check-expect (invaders-reached-bottom?
               (invaders-loi (world-invaders WORLD-INIT))) #false)


;;;;-----------------SHOW RESULT---------------------


;;;; Signature:
;; show-result: World -> Image
;;;; Purpose
;; GIVEN: a world
;; RETURNS: a image displays the game result and score
;;;; Function Definition
(define (show-result world)
  (if(killed-all-invaders? world)
     (place-image (text (string-append "You Win! Score: "
                                       (number->string (world-score world)))
                        40 
                        "blue")
                  (/ WIDTH 2)
                  (/ HEIGHT 2)
                  BACKGROUND)
     (place-image (text (string-append "You Lose! Score: "
                                       (number->string (world-score world)))
                        40
                        "blue")
                  (/ WIDTH 2)
                  (/ HEIGHT 2)
                  BACKGROUND)))
;;;; Tests
(check-expect (show-result WORLD-TEST7)
              (place-image
               (text "You Lose! Score: 30"
                        40
                        "blue")
                  (/ WIDTH 2)
                  (/ HEIGHT 2)
                  BACKGROUND))
(check-expect (show-result WORLD-TEST8)
              (place-image
               (text "You Win! Score: 30"
                        40
                        "blue")
                  (/ WIDTH 2)
                  (/ HEIGHT 2)
                  BACKGROUND))
     
                                      

(big-bang WORLD-INIT
          (to-draw draw-world)
          (on-tick world-step 0.15)
          (on-key key-handler)
          (stop-when end-game? show-result))