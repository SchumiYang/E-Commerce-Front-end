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

    let refreshSlider = setInterval(() => {next.click()}, 5000);

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
});