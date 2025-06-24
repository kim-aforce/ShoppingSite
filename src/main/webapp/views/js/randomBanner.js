document.addEventListener('DOMContentLoaded', () => {
  const banners = ['brad-pitt-01.jpg', 'brad-pitt-02.jpg', 'brad-pitt-03.jpg', 'godfather.jpg', 'god-father02.jpg'];
  const choice = banners[Math.floor(Math.random() * banners.length)];

  const imgEl = document.querySelector('.banner-img');
  if (imgEl) {
    imgEl.src = `../img/${choice}`;
  }

  document.documentElement.style.setProperty('--banner-image', `url('../img/${choice}')`);
});

