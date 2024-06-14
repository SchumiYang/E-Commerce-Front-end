function closeEvent(event, str) {
    if (!$('#' + str + '-placeholder').hasClass('active')) {
        return;
    }
    const $div = $('.modal-window');
    const rect = $div[0].getBoundingClientRect();

    // Get computed styles for the div
    const computedStyle = window.getComputedStyle($div[0]);
    const marginTop = parseInt(computedStyle.marginTop, 10);
    const marginRight = parseInt(computedStyle.marginRight, 10);
    const marginBottom = parseInt(computedStyle.marginBottom, 10);
    const marginLeft = parseInt(computedStyle.marginLeft, 10);

    // Check if the click is within the margin area
    const withinTopMargin = event.clientY < rect.top && event.clientY >= rect.top - marginTop;
    const withinBottomMargin = event.clientY > rect.bottom && event.clientY <= rect.bottom + marginBottom;
    const withinLeftMargin = event.clientX < rect.left && event.clientX >= rect.left - marginLeft;
    const withinRightMargin = event.clientX > rect.right && event.clientX <= rect.right + marginRight;

    if (withinTopMargin || withinBottomMargin || withinLeftMargin || withinRightMargin) {
        toggleWindow(str);
    }
};
function toggleWindow(str) {
    let holder = $('#' + str + '-placeholder');
    if (holder.hasClass('active')) {
        holder.off('click', (event) => closeEvent(event, str));
        holder.removeClass('active');
    } else {
        holder.addClass('active');
        setTimeout(function () {
            holder.on('click', (event) => closeEvent(event, str));
        }, 10);
    }
}