document.addEventListener('DOMContentLoaded', function() {
    const configItems = document.querySelectorAll('.config-item');

    configItems.forEach(configItem => {
        const targetClass = configItem.getAttribute('data-target');
        const targetElem = document.querySelector(`.${targetClass}`);

        configItem.addEventListener('mouseover', function() {
            if (targetElem) {
                targetElem.style.borderColor = '#00ffcc';
            }
            configItem.classList.add('config-item-hover');
        });

        configItem.addEventListener('mouseout', function() {
            if (targetElem) {
                targetElem.style.borderColor = 'transparent';
            }
            configItem.classList.remove('config-item-hover');
        });
    });
});

document.addEventListener('DOMContentLoaded', function() {
    const configItems = document.querySelectorAll('.config-item');
    var getPrice = document.getElementById('getp');
    var sub = document.getElementById('submit');

    configItems.forEach(item => {
        const target = item.getAttribute('data-target');
        const step = parseInt(item.getAttribute('data-step'));
        const input = item.querySelector('input[type="number"]');
        const minusButton = item.querySelector('.minus');
        const plusButton = item.querySelector('.plus');

        if (target === 'bandwidth') {
            minusButton.addEventListener('click', () => {
                let value = parseInt(input.value);
                if (value - step >= input.min) {
                    input.value = (value - step);
                    // sub.disabled = true;
                    getprice();
                } else {
                    alert("At least " + input.min);
                }
            });

            plusButton.addEventListener('click', () => {
                let value = parseInt(input.value);
                if (value + step <= input.max) {
                    input.value = (value + step);
                    // sub.disabled = true;
                    getprice();
                } else {
                    alert("Maximum " + input.max);
                }
            });
        } else {
            minusButton.addEventListener('click', () => {
                let value = parseInt(input.value);
                if (value > input.min) {
                    input.value = (value /= 2);
                    // sub.disabled = true;
                    getprice();
                } else {
                    alert("At least " + input.min);
                }
            });

            plusButton.addEventListener('click', () => {
                let value = parseInt(input.value);
                if (value < input.max) {
                    input.value = (value *= 2);
                    // sub.disabled = true;
                    getprice();
                } else {
                    alert("Maximum " + input.max);
                }
            });
        }
    });
});

function getprice() {
    var cpunum = parseInt(document.getElementById('cpu').value);
    var gpunum = parseInt(document.getElementById('gpu').value);
    var ramnum = parseInt(document.getElementById('ram').value);
    var memnum = parseInt(document.getElementById('mem').value);
    var bwnum = parseInt(document.getElementById('bw').value);
    var sub = document.getElementById('submit');

    var price = 100;
    var memPrice = 10;

    var total = (cpunum + gpunum + ramnum ) * price + memnum * memPrice + bwnum;

    document.getElementById('price').value = total;
    // sub.disabled = false;
}
