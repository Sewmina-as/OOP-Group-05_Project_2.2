/**
 * Verge — Main JavaScript (Premium Edition)
 * © 2026 Achintha Sewmina Gamage — All rights reserved
 *
 * Progressive enhancement: the app works fully without JS.
 * Scripts add animations, micro-interactions and UX polish on top.
 */

document.addEventListener('DOMContentLoaded', function () {

    // =========================================================
    // HELPERS
    // =========================================================
    function csrf() {
        const token  = document.querySelector('meta[name="_csrf"]');
        const header = document.querySelector('meta[name="_csrf_header"]');
        if (!token || !header) return {};
        const h = {};
        h[header.content] = token.content;
        return h;
    }

    function postJSON(url, extraHeaders) {
        return fetch(url, {
            method:  'POST',
            headers: Object.assign({ 'Content-Type': 'application/json' }, csrf(), extraHeaders || {})
        });
    }

    function showToast(message, type) {
        const icons = { success: '✓', error: '⚠', info: 'ℹ' };
        let c = document.querySelector('.toast-container');
        if (!c) { c = document.createElement('div'); c.className = 'toast-container'; document.body.appendChild(c); }
        const t = document.createElement('div');
        t.className = 'toast toast-' + (type || 'info');
        t.innerHTML =
            '<span class="toast-icon">' + (icons[type] || icons.info) + '</span>' +
            '<span class="toast-body"></span>' +
            '<button class="toast-close" aria-label="Dismiss">×</button>' +
            '<span class="toast-progress"></span>';
        t.querySelector('.toast-body').textContent = message;
        c.appendChild(t);
        const dismiss = function () {
            t.classList.add('toast-leaving');
            setTimeout(function () { t.remove(); }, 220);
        };
        t.querySelector('.toast-close').addEventListener('click', dismiss);
        setTimeout(dismiss, 4000);
    }

    // =========================================================
    // PAGE ENTRY TRANSITION
    // =========================================================
    document.body.classList.add('page-entering');

    // =========================================================
    // ACTIVE NAV PILL
    // =========================================================
    const path = window.location.pathname;
    document.querySelectorAll('.nav-pill').forEach(function (link) {
        const href = link.getAttribute('href') || '';
        if (href && path.startsWith(href.split('?')[0])) link.classList.add('active');
    });

    // =========================================================
    // CHARACTER COUNTER
    // =========================================================
    const postInput = document.querySelector('.post-input');
    const charHint  = document.querySelector('.char-hint');
    if (postInput && charHint) {
        const MAX = 1000;
        postInput.addEventListener('input', function () {
            const rem = MAX - postInput.value.length;
            charHint.textContent = rem + ' characters remaining';
            charHint.style.color = rem < 50 ? 'var(--danger)' : 'var(--text-muted)';
        });
    }

    // =========================================================
    // FLASH ALERTS → TOASTS
    // =========================================================
    document.querySelectorAll('.alert').forEach(function (alert) {
        const text = alert.textContent.trim();
        let type = 'info';
        if (alert.classList.contains('alert-success')) type = 'success';
        if (alert.classList.contains('alert-error'))   type = 'error';
        alert.remove();
        if (text) showToast(text, type);
    });

    // =========================================================
    // POST CREATE — spinner + empty guard
    // =========================================================
    const createForm = document.querySelector('.create-post-card form');
    if (createForm) {
        createForm.addEventListener('submit', function (e) {
            const content = createForm.querySelector('textarea[name="content"]');
            if (!content || !content.value.trim()) {
                e.preventDefault();
                showToast('Please write something before posting.', 'error');
                content && content.focus();
                return;
            }
            const btn = createForm.querySelector('button[type="submit"]');
            if (btn) btn.classList.add('btn-submitting');
        });
    }

    // =========================================================
    // LIKE BUTTON — AJAX
    // =========================================================
    document.querySelectorAll('.like-form').forEach(function (form) {
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            if (form.dataset.pending) return;
            form.dataset.pending = '1';

            const btn        = form.querySelector('.like-btn');
            const postCard   = form.closest('.post-card');
            const countEl    = postCard ? postCard.querySelector('.like-count') : null;
            const wasLiked   = btn.classList.contains('liked');
            const prevCount  = parseInt(countEl ? countEl.textContent : '0', 10);

            // Optimistic
            btn.classList.toggle('liked', !wasLiked);
            btn.querySelector('.like-label').textContent = wasLiked ? '🤍 Like' : '❤️ Liked';
            if (countEl) countEl.textContent = wasLiked ? prevCount - 1 : prevCount + 1;
            btn.classList.add('pop-anim');
            setTimeout(function () { btn.classList.remove('pop-anim'); }, 400);

            const url = form.action.replace(/\/like$/, '/like/ajax');
            postJSON(url)
                .then(function (r) { return r.ok ? r.json() : Promise.reject(r.status); })
                .then(function (d) {
                    btn.classList.toggle('liked', d.liked);
                    btn.querySelector('.like-label').textContent = d.liked ? '❤️ Liked' : '🤍 Like';
                    if (countEl) countEl.textContent = d.likeCount;
                })
                .catch(function () {
                    btn.classList.toggle('liked', wasLiked);
                    btn.querySelector('.like-label').textContent = wasLiked ? '❤️ Liked' : '🤍 Like';
                    if (countEl) countEl.textContent = prevCount;
                    showToast('Failed to update like. Please try again.', 'error');
                })
                .finally(function () { delete form.dataset.pending; });
        });
    });

    // =========================================================
    // COMMENT SUBMIT — AJAX
    // =========================================================
    document.querySelectorAll('.comment-form').forEach(function (form) {
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            if (form.dataset.pending) return;

            const input   = form.querySelector('.comment-input');
            const content = input ? input.value.trim() : '';
            if (!content) { showToast('Comment cannot be empty.', 'error'); return; }

            form.dataset.pending = '1';
            const submitBtn = form.querySelector('button[type="submit"]');
            if (submitBtn) submitBtn.classList.add('btn-submitting');

            const postId  = form.dataset.postId || form.action.match(/\/posts\/(\d+)\//)?.[1];
            const ajaxUrl = form.action.replace(/\/comment$/, '/comment/ajax');

            const body = new FormData();
            body.append('content', content);
            const csrfMeta = document.querySelector('meta[name="_csrf"]');
            const csrfHead = document.querySelector('meta[name="_csrf_header"]');

            const params = new URLSearchParams();
            params.append('content', content);
            const csrfMeta2 = document.querySelector('meta[name="_csrf"]');
            const csrfHead2 = document.querySelector('meta[name="_csrf_header"]');
            if (csrfMeta2 && csrfHead2) params.append(csrfHead2.content, csrfMeta2.content);

            fetch(ajaxUrl, {
                method: 'POST',
                headers: Object.assign({ 'Content-Type': 'application/x-www-form-urlencoded' }, csrf()),
                body: params.toString()
            })
            // try JSON first; fall back to FormData approach
            .then(function (r) {
                if (!r.ok) throw new Error(r.status);
                return r.json();
            })
            .then(function (d) {
                if (d.error) { showToast(d.error, 'error'); return; }

                // Inject new comment into DOM
                const postCard = form.closest('.post-card');
                const section  = postCard.querySelector('.comments-section');

                // Create the section if it doesn't exist yet
                let commentSection = section;
                if (!commentSection) {
                    commentSection = document.createElement('div');
                    commentSection.className = 'comments-section';
                    const wrap = postCard.querySelector('.comment-form-wrap');
                    postCard.insertBefore(commentSection, wrap);
                }

                const item = document.createElement('div');
                item.className = 'comment-item new-comment';
                item.setAttribute('data-comment-id', d.commentId);
                item.innerHTML =
                    '<div class="comment-avatar">' + d.authorInitial + '</div>' +
                    '<div class="comment-bubble">' +
                        '<a href="/profile/' + d.authorId + '" class="comment-author">' + escHtml(d.authorName) + '</a>' +
                        '<p class="comment-text">' + escHtml(d.content) + '</p>' +
                    '</div>' +
                    '<form class="delete-comment-form" action="/comments/' + d.commentId + '/delete" method="post">' +
                        '<button type="submit" class="comment-delete" title="Delete">×</button>' +
                    '</form>';

                commentSection.appendChild(item);
                attachDeleteComment(item.querySelector('.delete-comment-form'));

                // Update comment count
                const postCard2 = form.closest('.post-card');
                const countEl = postCard2 ? postCard2.querySelector('.comment-count') : null;
                if (countEl && d.commentCount !== undefined) countEl.textContent = d.commentCount;

                // Clear + close input
                input.value = '';
                const wrap = form.closest('.comment-form-wrap');
                if (wrap) { wrap.style.display = 'none'; }
                showToast('Comment posted!', 'success');
            })
            .catch(function () {
                showToast('Failed to post comment. Please try again.', 'error');
            })
            .finally(function () {
                delete form.dataset.pending;
                if (submitBtn) submitBtn.classList.remove('btn-submitting');
            });
        });
    });

    function escHtml(str) {
        return String(str)
            .replace(/&/g,'&amp;').replace(/</g,'&lt;')
            .replace(/>/g,'&gt;').replace(/"/g,'&quot;');
    }

    // =========================================================
    // DELETE COMMENT — AJAX
    // =========================================================
    function attachDeleteComment(form) {
        if (!form || form.dataset.bound) return;
        form.dataset.bound = '1';
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            if (form.dataset.pending) return;
            form.dataset.pending = '1';

            const item   = form.closest('.comment-item');
            const ajaxUrl = form.action.replace(/\/delete$/, '/delete/ajax');

            postJSON(ajaxUrl)
                .then(function (r) { return r.ok ? r.json() : Promise.reject(); })
                .then(function (d) {
                    if (d.success) {
                        item.classList.add('deleting');
                        setTimeout(function () { item.remove(); }, 280);
                        // Update comment count
                        const postCard = form.closest('.post-card');
                        const countEl  = postCard ? postCard.querySelector('.comment-count') : null;
                        if (countEl) countEl.textContent = Math.max(0, parseInt(countEl.textContent, 10) - 1);
                    } else {
                        showToast(d.error || 'Could not delete comment.', 'error');
                    }
                })
                .catch(function () { showToast('Could not delete comment.', 'error'); })
                .finally(function () { delete form.dataset.pending; });
        });
    }

    document.querySelectorAll('.delete-comment-form').forEach(attachDeleteComment);

    // =========================================================
    // DELETE POST — AJAX
    // =========================================================
    document.querySelectorAll('.delete-post-form').forEach(function (form) {
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            if (form.dataset.pending) return;

            const postCard = form.closest('.post-card');
            const ajaxUrl  = form.action.replace(/\/delete$/, '/delete/ajax');

            form.dataset.pending = '1';
            postJSON(ajaxUrl)
                .then(function (r) { return r.ok ? r.json() : Promise.reject(); })
                .then(function (d) {
                    if (d.success) {
                        postCard.classList.add('deleting');
                        setTimeout(function () { postCard.remove(); }, 380);
                        showToast('Post deleted.', 'success');
                    } else {
                        showToast(d.error || 'Could not delete post.', 'error');
                    }
                })
                .catch(function () { showToast('Could not delete post.', 'error'); })
                .finally(function () { delete form.dataset.pending; });
        });
    });

    // =========================================================
    // COMMENT BOX TOGGLE
    // =========================================================
    document.querySelectorAll('.comment-form-wrap').forEach(function (w) {
        w.style.display = 'none';
    });

    window.toggleCommentBox = function (btn) {
        const postCard = btn.closest('.post-card');
        if (!postCard) return;
        const wrap = postCard.querySelector('.comment-form-wrap');
        if (!wrap) return;
        const isHidden = wrap.style.display === 'none' || !wrap.style.display;
        wrap.style.display = isHidden ? 'block' : 'none';
        if (isHidden) {
            const input = postCard.querySelector('.comment-input');
            if (input) { input.focus(); input.scrollIntoView({ behavior: 'smooth', block: 'nearest' }); }
        }
    };

    document.querySelectorAll('.action-label').forEach(function (label) {
        label.addEventListener('click', function () {
            const btn = label.closest('button') || label.parentElement;
            if (btn) window.toggleCommentBox(btn);
        });
    });

    // =========================================================
    // DARK MODE TOGGLE
    // =========================================================
    document.querySelectorAll('#themeToggle').forEach(function (btn) {
        btn.addEventListener('click', function () {
            const isDark = document.documentElement.getAttribute('data-theme') === 'dark';
            if (isDark) {
                document.documentElement.removeAttribute('data-theme');
                localStorage.setItem('verge-theme', 'light');
            } else {
                document.documentElement.setAttribute('data-theme', 'dark');
                localStorage.setItem('verge-theme', 'dark');
            }
        });
    });
    // =========================================================
    // NOTIFICATION BELL DROPDOWN
    // =========================================================
    const notifBell     = document.getElementById('notifBell');
    const notifDropdown = document.getElementById('notifDropdown');

    if (notifBell && notifDropdown) {
        notifBell.addEventListener('click', function (e) {
            e.stopPropagation();
            notifDropdown.classList.toggle('open');
        });
        document.addEventListener('click', function (e) {
            if (!notifDropdown.contains(e.target) && e.target !== notifBell) {
                notifDropdown.classList.remove('open');
            }
        });
        notifDropdown.addEventListener('click', function (e) { e.stopPropagation(); });

        document.querySelectorAll('.notif-link').forEach(function (link) {
            link.addEventListener('click', function () {
                const id = link.getAttribute('data-notif-id');
                if (id) postJSON('/api/notifications/' + id + '/read').catch(function () {});
            });
        });

        // Poll badge every 30s
        setInterval(function () {
            fetch('/api/notifications/unread-count')
                .then(function (r) { return r.ok ? r.json() : null; })
                .then(function (data) {
                    if (!data) return;
                    let badge = document.getElementById('notifBadge');
                    if (data.count > 0) {
                        if (!badge) {
                            badge = document.createElement('span');
                            badge.className = 'badge-count';
                            badge.id = 'notifBadge';
                            notifBell.appendChild(badge);
                        }
                        badge.textContent = data.count;
                    } else if (badge) {
                        badge.remove();
                    }
                })
                .catch(function () {});
        }, 30000);
    }

    // =========================================================
    // BUTTON RIPPLE
    // =========================================================
    document.querySelectorAll('.btn').forEach(function (btn) {
        btn.addEventListener('click', function (e) {
            const rect   = btn.getBoundingClientRect();
            const size   = Math.max(rect.width, rect.height);
            const ripple = document.createElement('span');
            ripple.style.cssText =
                'position:absolute;border-radius:50%;background:rgba(255,255,255,.32);pointer-events:none;' +
                'width:' + size + 'px;height:' + size + 'px;' +
                'left:' + (e.clientX - rect.left  - size / 2) + 'px;' +
                'top:'  + (e.clientY - rect.top   - size / 2) + 'px;' +
                'animation:rippleAnim .5s ease-out forwards;';
            btn.appendChild(ripple);
            setTimeout(function () { ripple.remove(); }, 500);
        });
    });
    if (!document.getElementById('rippleStyle')) {
        const s = document.createElement('style');
        s.id = 'rippleStyle';
        s.textContent = '@keyframes rippleAnim{from{transform:scale(0);opacity:1;}to{transform:scale(2.5);opacity:0;}}';
        document.head.appendChild(s);
    }

    // =========================================================
    // SCROLL-IN ANIMATION (IntersectionObserver)
    // =========================================================
    if ('IntersectionObserver' in window) {
        const io = new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                    io.unobserve(entry.target);
                }
            });
        }, { threshold: 0.06 });

        document.querySelectorAll('.post-card').forEach(function (card) {
            if (card.getBoundingClientRect().top > window.innerHeight) {
                card.style.cssText += 'opacity:0;transform:translateY(20px);transition:opacity .4s ease,transform .4s ease;';
                io.observe(card);
            }
        });
    }

});
