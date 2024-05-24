;; Initialize package sources
(require 'package)


(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(defvar bootstrap-version)
(let ((bootstrap-file
      (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
        "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
        'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(column-number-mode)

;; Enable line numbers only for prog mode
(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode t)))

(add-hook 'window-setup-hook 'toggle-frame-maximized t)

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

(set-face-attribute 'default nil :font "FiraCode Nerd Font" :height 110)

(use-package all-the-icons)

(global-hl-line-mode)

(use-package powerline :ensure t)

(use-package spaceline
  :after powerline
  :init
  (spaceline-helm-mode)
  (spaceline-spacemacs-theme))

(add-hook 'emacs-startup-hook (lambda () (find-file "~/Documents/org/index.org")))

(use-package swiper :ensure t)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package doom-themes
    :init
    (load-theme 'doom-Iosvkem t))

(defun darker-faces ()
  "must be more darker then default colorcheme"
  (interactive)
  (face-remap-add-relative 'default
                           :background "gray8"))

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package company-posframe
  :after posframe
  :config (company-posframe-mode 1))

(use-package posframe)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag))
  :hook (treemacs-mode . darker-faces))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package vterm
  :ensure t
  :hook (vterm-mode . darker-faces))

(use-package dimmer
  :config
  (dimmer-configure-helm)
  (dimmer-configure-which-key)
  (dimmer-mode t))

(use-package vdiff)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-set-key (kbd "<mouse-9>") 'next-buffer)
(global-set-key (kbd "<mouse-8>") 'previous-buffer)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-nerd-commenter
  :config
  (global-set-key (kbd "C-/") 'evilnc-comment-or-uncomment-lines))

(use-package general
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (rune/leader-keys
    "t" '(treemacs :which-key "treemacs-toggle")
    "h" '(info :which-key "documentation")
    "e" '(emojify-insert-emoji :which-key "insert emoji")
    "mc" '(general/config-file :which-key "Open configuration file")
    "my" '(general/yank-window-filePath :which-key "copy filepath to clipboard")))

(defun general/config-file ()
  "Open emacs configuration file"
  (interactive)
  (find-file "~/.config/emacs/init.org"))

(defun general/yank-window-filePath ()
  (interactive)
  (kill-new (buffer-file-name)))

(use-package avy
  :after general
  ;; :general (:states 'normal "s" 'avy-goto-word-0)
  :config (avy-setup-default))

(setq make-backup-files nil)

(global-visual-line-mode t)

(use-package emojify
  :hook (org-mode . emojify-mode))

(use-package origami
  :hook (prog-mode . origami-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package git-gutter
  :config
  (custom-set-variables
   '(git-gutter:update-interval 2)
   '(git-gutter:modified-sign "▌") 
   '(git-gutter:added-sign "▌")    
   '(git-gutter:deleted-sign "▌"))

  (set-face-foreground 'git-gutter:modified "DeepSkyBlue4") 
  (set-face-foreground 'git-gutter:added "SpringGreen4")
  (set-face-foreground 'git-gutter:deleted "brown4")
  (global-git-gutter-mode +1))

(use-package yasnippet
  :init
  (yas-global-mode 1))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/programming")
    (setq projectile-project-search-path '("~/programming")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui)

(use-package tree-sitter)

(use-package tree-sitter-langs)

(use-package flycheck)

(use-package multi-compile)

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook ((js-mode . lsp-deferred)
         (typescript-mode . lsp-deferred))
  :config
  (setq typescript-indent-level 4))

(use-package async)

(use-package php-mode
  :hook (php-mode . tree-sitter-hl-mode)
  :hook (php-mode . lsp-mode))

(use-package rustic)

(use-package racket-mode)

(use-package go-eldoc)

(use-package company-go)

(use-package go-mode
  :config
  (setq-default gofmt-command "goimports")
  (add-hook 'go-mode-hook 'go-eldoc-setup)
  (add-hook 'go-mode-hook (lambda ()
                            (set (make-local-variable 'company-backends) '(company-go))
                            (company-mode)))
  (add-hook 'go-mode-hook 'yas-minor-mode)
  (add-hook 'go-mode-hook 'flycheck-mode))

(use-package yaml-mode
  :init
  (add-hook 'yaml-mode-hook (lambda () (display-line-numbers-mode t))))

(use-package lua-mode)

(use-package dockerfile-mode)

(use-package markdown-mode)

(use-package dotenv-mode)

(use-package twig-mode)

(use-package emmet-mode)

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))
(defun efs/org-font-setup ()
  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :weight 'regular :height (cdr face))))

;; Ensure that anything that should be fixed-pitch in Org files appears that way
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
(set-face-attribute 'org-date nil :inherit 'fixed-pitch)

(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (setq org-src-fontify-natively t)
  (efs/org-font-setup)
  (setq org-confirm-elisp-link-function nil))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)))

(push '("conf-unix" . conf-unix) org-src-lang-modes)

;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
		      (expand-file-name "~/.config/emacs/init.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(setq org-clock-sound "~/.config/emacs/alarm-clock-elapsed.wav")

(use-package org-capture
  :ensure nil
  :after org
  :preface
  (defvar template/org-contacts
    (concat "* %(org-contacts-template-name)\n"
            ":PROPERTIES:\n"
            ":tags: :hash: \n"
            ":ADDRESS: 🏚 \n"
            ":BIRTHDAY: 🎂 \n"
            ":EMAIL: :email: \n"
            ":TELEGRAM: :airplane: \n"
            ":NOTE: 📓 \n"
            ":END:"))
  :init
  (setq org-capture-templates
        `(("c" "Contact" entry (file "~/Documents/org/contacts.org"),
           template/org-contacts
           :empty-lines 1))))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/Documents/org/roam")
  (org-roam-capture-templates
   `(("d" "default" plain
      "\ntags:"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}")
      :unnarrowed t)
     ("j" "jira-task" plain
      ,(concat
       "\ntags:"
       "\njira link https://crab.media/browse/${title}"
       "\ngit branch: ~feature/${title}/FILL_ME~"
       "\nmarkdown link:"
       "\n#+BEGIN_SRC md"
       "\n  [${title}](https://crab.media/browse/${title}) -- FILL_ME"
       "\n#+END_SRC")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}")
      :unnarrowed t)))

  :bind
  (("C-c n l" . org-roam-buffer-toggle)
   ("C-c n f" . org-roam-node-find)
   ("C-c n i" . org-roam-node-insert)
   :map org-mode-map
   ("C-M-i" . completion-at-point))
  :config
  (org-roam-setup))

(use-package websocket
              :after org-roam)

(use-package org-roam-ui
              :after org-roam ;; or :after org
              ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
              ;;         a hookable mode anymore, you're advised to pick something yourself
              ;;         if you don't care about startup time, use
              ;;  :hook (after-init . org-roam-ui-mode)
              :config
              (setq org-roam-ui-sync-theme t
                    org-roam-ui-follow t
                    org-roam-ui-update-on-save t
                    org-roam-ui-open-on-start t))

(defun agenda-init ()
  "Initialize agenda"
  (interactive)
  (setq org-agenda-files
        (directory-files-recursively "~/Documents/org/" ".org$")))

(use-package org-download
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'org (org-download-enable))
  (setq-default org-download-image-dir "~/Documents/org/imgs"))

(straight-use-package '(el-easydraw
                        :type git
                        :host github
                        :repo "misohena/el-easydraw"))

(require 'edraw-org)
(edraw-org-setup-default)

(use-package org-contacts
  :custom (org-contacts-files '("~/org/roam/contacts.org")))

(use-package ox-jira)

(straight-use-package '(telega
                        :type git
                        :host github
                        :repo "zevlg/telega.el"))
(use-package telega
  :config (setq telega-use-docker t))

(straight-use-package 'command-log-mode)
(use-package command-log-mode)

(straight-use-package 'counsel)
(use-package counsel
  :bind (("C-M-j" . counsel-switch-buffer)
         ("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))
