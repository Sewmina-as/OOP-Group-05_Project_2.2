/**
 * SocialApp — Main JavaScript
 *
 * Progressive enhancement: the app works fully without JS.
 * These scripts add convenience features on top of the HTML forms.
 */

document.addEventListener('DOMContentLoaded', function () {

    // =========================================================
    // CHARACTER COUNTER for post textarea
    // Updates the hint text as the user types to show remaining chars.
    // =========================================================
    const postInput = document.querySelector('.post-input');
    const charHint  = document.querySelector('.char-hint');

    if (postInput && charHint) {
        const MAX = 1000;

        postInput.addEventListener('input', function () {
            const remaining = MAX - postInput.value.length;
            charHint.textContent = remaining + ' characters remaining';

            // Turn red when running low
            charHint.style.color = remaining < 50
                ? 'var(--color-error)'
                : 'var(--color-text-muted)';
        });
    }

    // =========================================================
    // AUTO-DISMISS flash alerts after 4 seconds
    // =========================================================
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(function (alert) {
        setTimeout(function () {
            alert.style.transition = 'opacity 0.4s ease';
            alert.style.opacity   = '0';
            setTimeout(function () { alert.remove(); }, 400);
        }, 4000);
    });

    // =========================================================
    // CONFIRM before deleting posts or comments
    // Prevents accidental deletes (graceful fallback: onclick attr also handles this).
    // =========================================================
    document.querySelectorAll('form[data-confirm]').forEach(function (form) {
        form.addEventListener('submit', function (e) {
            const message = form.getAttribute('data-confirm');
            if (!confirm(message)) {
                e.preventDefault();
            }
        });
    });

    // =========================================================
    // HIGHLIGHT the active nav link based on the current URL
    // =========================================================
    const currentPath = window.location.pathname;
    document.querySelectorAll('.nav-link').forEach(function (link) {
        if (link.getAttribute('href') === currentPath) {
            link.style.color = 'var(--color-primary)';
            link.style.fontWeight = '700';
        }
    });

    // =========================================================
    // AUTO-FOCUS the comment input when the user clicks "Comment"
    // =========================================================
    document.querySelectorAll('.action-label').forEach(function (label) {
        label.style.cursor = 'pointer';
        label.addEventListener('click', function () {
            // Find the nearest comment input in the same post card
            const postCard = label.closest('.post-card');
            if (postCard) {
                const commentInput = postCard.querySelector('.comment-input');
                if (commentInput) {
                    commentInput.focus();
                    commentInput.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
                }
            }
        });
    });

});
