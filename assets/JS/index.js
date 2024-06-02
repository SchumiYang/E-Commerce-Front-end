document.addEventListener('DOMContentLoaded', function() {
    let list = document.querySelector('.list');
    let items = document.querySelectorAll('.slider .list .item');
    let dots = document.querySelectorAll('.slider .dots li');
    let prev = document.getElementById('prev');
    let next = document.getElementById('next');

    let active = 0;
    let lengthItems = items.length - 1;


    next.onclick = function() {
        if (active + 1 > lengthItems) {
            active = 0;
        } else {
            active += 1;
        }
        reloadSlider();
    }

    prev.onclick = function() {
        if (active - 1 < 0) {
            active = lengthItems;
        } else {
            active -= 1;
        }
        reloadSlider();
    }

    let refreshSlider;

    function startSliderInterval() {
        refreshSlider = setInterval(() => {
            next.click();
        }, 5000);
    }

    function resetSliderInterval() {
        clearInterval(refreshSlider);
        startSliderInterval();
    }

    // Start the slider interval when the page loads
    startSliderInterval();

    // Add event listener to reset the interval on user click
    document.addEventListener('click', (event) => {
        resetSliderInterval();
    });

    function reloadSlider() {
        let checkLeft = items[active].offsetLeft;
        list.style.left = -checkLeft + 'px';

        dots.forEach((dot, index) => {
            dot.classList.toggle('active', index === active);
        });
    }

    dots.forEach((li, key) => {
        li.addEventListener('click',function(){
            active = key;
            reloadSlider();
        })
    })

    let scrollers = document.querySelectorAll('.scroller');

    if (!window.matchMedia("(prefers-reduced-motion: reduce").matches){
        addAnimation();
    }

    function addAnimation(){
        scrollers.forEach(scroller => {
            scroller.setAttribute("data-animated", true);

            const productList = scroller.querySelector('.product-list');
            const productItem = Array.from(productList.children);

            productItem.forEach(item => {
                const duplicatedItem = item.cloneNode(true);
                // console.log(duplicatedItem);
                duplicatedItem.setAttribute('aria-hidden', true);
                productList.appendChild(duplicatedItem);
            })

            // console.log(productItem);
        });
    }

    

});