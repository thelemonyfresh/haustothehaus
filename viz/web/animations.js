function flash(args) {
  console.log(`flash called with ${args}`);
  // $(selector).show();
  // await sleep(duration);
  // $(selector).hide();
}


function  pulse(args) {
  console.log(`pulse called with ${args}`);
  // $(selector).velocity({ opacity: 0 }, {
  //   duration: duration/4,
  //   easing: 'easeOutCubix',
  //   queue: false
  // });
  // await sleep(duration/2);
  // $(selector).velocity({ opacity: 1 },
  //                      { duration: 3*duration/2,
  //                        queue: false
  //                      });
}

// filename, duration
let quadrantsFull = Array(4).fill(false);

async function gif(args) {
  console.log(`gif called with ${args}`);

  let currentQuadrant = quadrantsFull.indexOf(false);
  if (currentQuadrant == -1) currentQuadrant = 0;

  console.log(`quadrantsFull: ${quadrantsFull}`);
  console.log(`currentQuadrant: ${currentQuadrant}`);

  quadrants = [
    'bottom right',
    'bottom left',
    'top right',
    'top left'
  ];

  let elem = document.createElement("img");
  elem.setAttribute("src", "gifs/dancing_data.gif");
  elem.setAttribute("class", quadrants[currentQuadrant]);

  let currentId = Math.random().toString(36).substring(7);
  elem.setAttribute("id", currentId);

  quadrantsFull[currentQuadrant] = true;
  document.body.appendChild(elem);

  setTimeout(() => { removeElementFromQuadrant(currentQuadrant, elem); }, 1000);
}

function removeElementFromQuadrant(quadrant, element) {
  document.body.removeChild(element);
  quadrantsFull[quadrant] = false;
}


function rotate(args) {
  console.log(`rotate called with ${args}`);
  // $(selector).animate({deg: val1}, {
  //   duration: duration,
  //   step: function(now) {
  //     // in the step-callback (that is fired each step of the animation),
  //     // you can use the `now` paramter which contains the current
  //     // animation-position (`0` up to `angle`)
  //     $(selector).css({
  //       transform: 'rotate(' + now + 'deg)'
  //     });
  //   }
  // });
}

function color(args) {
  console.log(`color called with ${args}`);
  // $(selector).velocity({fill: val1 },
  //                      { duration: duration,
  //                        easing: 'easeOutCirc',
  //                        queue: false
  //                      });
}

function appendText(args) {
  console.log(`appentText called with ${args}`);
  // $(selector).prepend(val1 + " ");
}

function fallingText(args) {
  console.log(`fallingText called with ${args}`);
  // var elem = document.createElement("h1");
  // elem.textContent = text;
  // elem.style.position = 'fixed';
  // elem.style.color = '#f9de2a';

  // start_x = Math.floor(window.innerWidth * Math.random()) + 'px';
  // start_y = Math.floor(window.innerHeight * Math.random()) + 'px';

  // console.log(start_x);
  // console.log(start_y);

  // elem.style.left = start_x;
  // elem.style.top = start_y;

  // document.body.appendChild(elem);

  // $(elem).velocity(
  //   {
  //     top: window.innerHeight*Math.random(),
  //     left: window.innerWidth*Math.random()
  //   },
  //   {
  //     duration: Math.round(duration),
  //     easing: 'linear',
  //     complete: function() {
  //       // remove when animation complete
  //       elem.remove();
  //     }
  //   }
  // );
};

function cuePosition(args) {
  console.log(`cuePosition called with ${args}`);
  // console.log(`w: ${parseFloat(window.innerWidth)}`);
  // console.log(`val1: ${parseFloat(val1)}`);
  // let position = parseFloat(window.innerWidth) * parseFloat(val1) ;//* parseFloat(val1);
  // console.log(`pos: ${position}`);
  // $(selector).css('top', position);
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}