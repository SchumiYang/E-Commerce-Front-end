$(document).ready(function () {
    const list = document.querySelector('.list');
    const items = document.querySelectorAll('.slider .list .item');
    const dots = document.querySelectorAll('.slider .dots li');
    const prev = document.getElementById('prev');
    const next = document.getElementById('next');

    let active = 0;
    const lengthItems = items.length - 1;
    let refreshSlider;

    function reloadSlider() {
        const checkLeft = items[active].offsetLeft;
        list.style.left = -checkLeft + 'px';

        dots.forEach((dot, index) => {
            dot.classList.toggle('active', index === active);
        });
    }

    function startSliderInterval() {
        refreshSlider = setInterval(() => {
            active = (active + 1 > lengthItems) ? 0 : active + 1;
            reloadSlider();
        }, 5000);
    }

    function resetSliderInterval() {
        clearInterval(refreshSlider);
        startSliderInterval();
    }

    next.addEventListener('click', () => {
        active = (active + 1 > lengthItems) ? 0 : active + 1;
        reloadSlider();
    });

    prev.addEventListener('click', () => {
        active = (active - 1 < 0) ? lengthItems : active - 1;
        reloadSlider();
    });

    document.addEventListener('click', resetSliderInterval);

    dots.forEach((dot, index) => {
        dot.addEventListener('click', () => {
            active = index;
            reloadSlider();
        });
    });

    const scrollers = document.querySelectorAll('.scroller');

    if (!window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
        addAnimation();
    }

    function addAnimation() {
        scrollers.forEach(scroller => {
            scroller.setAttribute("data-animated", true);

            const productList = scroller.querySelector('.product-list');
            const productItems = Array.from(productList.children);

            productItems.forEach(item => {
                const duplicatedItem = item.cloneNode(true);
                duplicatedItem.setAttribute('aria-hidden', true);
                productList.appendChild(duplicatedItem);
            });
        });
    }

    // Uncomment the line below to start the slider interval when the page loads
    startSliderInterval();

});