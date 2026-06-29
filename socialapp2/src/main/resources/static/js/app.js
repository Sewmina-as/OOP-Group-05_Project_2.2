/**
 * Verge — Main JavaScript
 *
 * Progressive enhancement: the app works fully without JS.
 * These scripts add convenience features on top of the HTML forms.
 */

document.addEventListener('DOMContentLoaded', function () {

    // =========================================================
    // CHARACTER COUNTER for post textarea
    // =========================================================
    const postInput = document.querySelector('.post-input');
    const charHint  = document.querySelector('.char-hint');

    if (postInput && charHint) {
        const MAX = 1000;

        postInput.addEventListener('input', function () {
            const remaining = MAX - postInput.value.length;
            charHint.textContent = remaining + ' characters remaining';
            charHint.style.color = remaining < 50
                ? 'var(--danger)'
                : 'var(--text-muted)';
        });
    }

    // =========================================================
    // TOAST NOTIFICATIONS
    // Converts server-rendered flash alerts (.alert) into floating
    // toasts with a progress bar, instead of static inline banners.
    // =========================================================
    function getToastContainer() {
        let c = document.querySelector('.toast-container');
        if (!c) {
            c = document.createElement('div');
            c.className = 'toast-container';
            document.body.appendChild(c);
        }
        return c;
    }

    function showToast(message, type) {
        const icons = { success: '✓', error: '⚠', info: 'ℹ' };
        const container = getToastContainer();
        const toast = document.createElement('div');
        toast.className = 'toast toast-' + type;
        toast.innerHTML =
            '<span class="toast-icon">' + (icons[type] || icons.info) + '</span>' +
            '<span class="toast-body"></span>' +
            '<button type="button" class="toast-close" aria-label="Dismiss">×</button>' +
            '<span class="toast-progress"></span>';
        toast.querySelector('.toast-body').textContent = message;
        container.appendChild(toast);

        const dismiss = function () {
            toast.classList.add('toast-leaving');
            setTimeout(function () { toast.remove(); }, 220);
        };
        toast.querySelector('.toast-close').addEventListener('click', dismiss);
        setTimeout(dismiss, 4000);
    }

    // Pick up any server-rendered flash alerts on page load and
    // present them as toasts instead of static banners.
    document.querySelectorAll('.alert').forEach(function (alert) {
        const text = alert.textContent.trim();
        let type = 'info';
        if (alert.classList.contains('alert-success')) type = 'success';
        if (alert.classList.contains('alert-error')) type = 'error';
        alert.remove();
        if (text) showToast(text, type);
    });

    // =========================================================
    // LIKE BUTTON micro-animation
    // Brief pop/rotate on the heart icon before the form submits,
    // so the click feels immediate even though the page reloads.
    // =========================================================
    document.querySelectorAll('.post-actions form').forEach(function (form) {
        const btn = form.querySelector('button[type="submit"]');
        if (!btn) return;
        const span = btn.querySelector('span');
        if (!span) return;
        span.classList.add('like-icon');

        form.addEventListener('submit', function (e) {
            if (form.dataset.submitting) return; // already animating, let it go through
            e.preventDefault();
            btn.classList.add('pop-anim');
            form.dataset.submitting = 'true';
            setTimeout(function () {
                if (typeof form.requestSubmit === 'function') {
                    form.requestSubmit();
                } else {
                    form.submit();
                }
            }, 160);
        });
    });

    // =========================================================
    // CONFIRM before deleting posts or comments
    // =========================================================
    document.querySelectorAll('form[data-confirm]').forEach(function (form) {
        form.addEventListener('submit', function (e) {
            const message = form.getAttribute('data-confirm');
            if (!confirm(message)) e.preventDefault();
        });
    });

    // =========================================================
    // HIGHLIGHT the active nav link based on the current URL
    // =========================================================
    const currentPath = window.location.pathname;
    document.querySelectorAll('.nav-link').forEach(function (link) {
        if (link.getAttribute('href') === currentPath) {
            link.style.color = 'var(--primary)';
            link.style.fontWeight = '700';
        }
    });

    // =========================================================
    // COMMENT BOX toggling on the feed
    // Hidden by default, opens (and focuses) on "Comment" click.
    // =========================================================
    document.querySelectorAll('.comment-form-wrap').forEach(w => w.style.display = 'none');

    document.querySelectorAll('.action-label').forEach(function (label) {
        label.style.cursor = 'pointer';
        label.addEventListener('click', function () {
            const postCard = label.closest('.post-card');
            if (!postCard) return;
            const wrap = postCard.querySelector('.comment-form-wrap');
            if (!wrap) return;
            const isHidden = wrap.style.display === 'none' || wrap.style.display === '';
            wrap.style.display = isHidden ? 'block' : 'none';
            if (isHidden) {
                const input = postCard.querySelector('.comment-input');
                if (input) {
                    input.focus();
                    input.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
                }
            }
        });
    });

    // =========================================================
    // DARK MODE TOGGLE
    // Theme is applied before paint via inline script in <head>;
    // this just wires up the button and persists the choice.
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
    // NOTIFICATION BELL dropdown
    // =========================================================
    const notifBell = document.getElementById('notifBell');
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

        notifDropdown.addEventListener('click', function (e) {
            e.stopPropagation();
        });

        // Mark an individual notification as read right before navigating to it.
        // We don't block navigation on the fetch — it's best-effort, fire-and-forget.
        document.querySelectorAll('.notif-link').forEach(function (link) {
            link.addEventListener('click', function () {
                const id = link.getAttribute('data-notif-id');
                if (!id) return;
                const csrfToken = document.querySelector('meta[name="_csrf"]');
                const csrfHeader = document.querySelector('meta[name="_csrf_header"]');
                const headers = { 'Content-Type': 'application/json' };
                if (csrfToken && csrfHeader) headers[csrfHeader.content] = csrfToken.content;
                fetch('/api/notifications/' + id + '/read', { method: 'POST', headers: headers })
                    .catch(function () { /* best-effort; ignore failures */ });
            });
        });

        // Poll unread count every 30s so the badge stays fresh without a full reload.
        const notifBadgeEl = document.getElementById('notifBadge');
        setInterval(function () {
            fetch('/api/notifications/unread-count')
                .then(function (res) { return res.ok ? res.json() : null; })
                .then(function (data) {
                    if (!data) return;
                    if (data.count > 0) {
                        if (notifBadgeEl) {
                            notifBadgeEl.textContent = data.count;
                        } else {
                            const badge = document.createElement('span');
                            badge.className = 'badge-count';
                            badge.id = 'notifBadge';
                            badge.textContent = data.count;
                            notifBell.appendChild(badge);
                        }
                    } else {
                        const existing = document.getElementById('notifBadge');
                        if (existing) existing.remove();
                    }
                })
                .catch(function () { /* polling endpoint may not exist yet — fail silently */ });
        }, 30000);
    }

});
