wp.customize('blogname', value => {
  value.bind(to => {
    Array.prototype.slice.call(
      document.querySelectorAll('.brand')
    ).forEach(el => {
      el.textContent = to;
    });
  });
});
