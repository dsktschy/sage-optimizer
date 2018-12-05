wp.customize('blogname', value => {
  value.bind(to => {
    document.querySelectorAll('.brand').forEach(el => {
      el.textContent = to;
    });
  });
});
