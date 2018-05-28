export const triggerTab = () => {
  if (window.location.hash !== '')
   $(`a[href="${window.location.hash}"]`).trigger('click')
}
