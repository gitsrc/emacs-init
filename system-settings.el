;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                           ;;
;;(@* "System Dependent Settings")                           ;;
;;                                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst my-platform
  (cond ((or (string-equal system-type "darwin")
             (eq window-system 'ns)
             (eq window-system 'mac))
	 'macosx)
	((or (string-equal system-type "ms-dos")
             (string-equal system-type "windows-nt")
	     (string-equal system-type "cygwin"))
	 'windows)
        (t
         'linux))
  "The platform on which we are currently running, derived from
the variables `system-type' and `window-system'. Value is a
symbol. For the moment, all *nix variants are converted to
`linux', though this can be generalized later if needed")

;; ATTN This is a bit of a mess below.
;; Put the settings in their own functions or settings
;; and use my-platform

;; Operating-system-specific settings

(let* ((ostype (getenv "OSTYPE"))
       (myos (and ostype (downcase (getenv "OSTYPE")))))
  (when myos
    (cond
     ((string-equal myos "linux")
      (setq list-directory-verbose-switches "-HlrtF")
      (setq list-directory-brief-switches   "-CHvF"))
     (t
      (setq list-directory-verbose-switches "-lrtF")
      (setq list-directory-brief-switches   "-CF"))
     )))


;; Non-terminal/Windowing System Settings

(when window-system
  (setq frame-title-format '("" invocation-name " <%b>"))
  (tooltip-mode -1)
  (mouse-wheel-mode t)
  (blink-cursor-mode t)
  (setq visible-bell 't)           
  )


;; Linux-specific settings

(when (eq window-system 'x)
  ;; Faces
  (set-face-background 'highlight "tan")   ;;; "red" is nice also
  ;; Command Defaults
  (setq dired-guess-shell-alist-user
        (list
         (list "\\.py\\'"    "python")
         (list "\\.pl\\'"    "perl")
         (list "\\.rb\\'"    "ruby")
         (list "\\.r\\'"     "R --no-save --no-readline --slave --file=?")
         ))
  )


;; Emacs Version Specific Settings

(when (equal emacs-major-version 23)
  (set-cursor-color "gray40")
  )


;; Mac OSX Specific Settings (see ~/.emacs.d/my-env.el for more)

(when (or (eq window-system 'ns)   ; Gnu Emacs 23+ (Cocoa/NextStep)
          (eq window-system 'mac)  ; Carbon Emacs 22
          (string-equal system-type "darwin"))
  (when window-system
    (if (eq window-system 'mac)
        (message "MAC CARBON SYSTEM CHECK")
      (message "MAC COCOA SYSTEM CHECK"))
    (setq default-frame-alist           ; new frames after initial one
          '((top . 48) (left . 24)   
            (width . 180) (height . 56)
            (cursor-color . "gray40")
            (menu-bar-lines . 1) (tool-bar-lines . 0))))

  ;;
  ;; Modifier Keys
  ;;
  (setq mac-command-modifier  'meta) ;;; Emacs 23 defaults are different
  (setq mac-option-modifier   'alt)
  (setq mac-function-modifier 'super)
  (setq mac-pass-command-to-system nil)  ; not sure about the last two
  (setq mac-pass-control-to-system nil)
  ;;
  ;; Mouse Emulation
  ;;
  ;; With Cocoa, use super (fn) for mouse 2 and alt (option) for mouse 3,
  ;; using shift with all combinations to indicate the down-mouse variety.
  ;; It's not yet obvious how to get the analogous drag versions as these
  ;; are produced from event pairs.
  ;;
  (setq mac-emulate-three-button-mouse 'reverse)  ; carbon only
  (define-key key-translation-map     [s-mouse-1]          [mouse-2])
  (define-key key-translation-map   [C-s-mouse-1]        [C-mouse-2])
  (define-key key-translation-map   [M-s-mouse-1]      [M-C-mouse-2])

  (define-key key-translation-map   [s-S-mouse-1]     [down-mouse-2])
  (define-key key-translation-map [C-s-S-mouse-1]   [C-down-mouse-2])
  (define-key key-translation-map [M-s-S-mouse-1] [M-C-down-mouse-2])

  (define-key key-translation-map     [A-mouse-1]          [mouse-3])
  (define-key key-translation-map   [C-A-mouse-1]        [C-mouse-3])
  (define-key key-translation-map   [M-A-mouse-1]      [M-C-mouse-3])

  (define-key key-translation-map   [A-S-mouse-1]     [down-mouse-3])
  (define-key key-translation-map [C-A-S-mouse-1]   [C-down-mouse-3])
  (define-key key-translation-map [M-A-S-mouse-1] [M-C-down-mouse-3])
  ;;
  ;; Command Defaults
  ;;
  (setq dired-guess-shell-alist-user
        (list
         (list "\\.pdf\\'"   "open")
         (list "\\.gif\\'"   "open")
         (list "\\.jpe?g\\'" "open")
         (list "\\.png\\'"   "open")
         (list "\\.tiff\\'"  "open")
         (list "\\.py\\'"    "python")
         (list "\\.pl\\'"    "perl")
         (list "\\.rb\\'"    "ruby")
         (list "\\.r\\'"     "R --no-save --no-readline --slave --file=?")
         ))
  )


