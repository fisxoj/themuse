var _fisxoj$themuse$Native_CSRF = function () {
  var tag = document.head.querySelector('meta[name="csrf-token"]')
  , csrfToken = (tag === null || (typeof tag.content !== "string"))
        ? _elm_lang$core$Maybe$Nothing : _elm_lang$core$Maybe$Just(tag.content);

  return {
    csrfToken: csrfToken
  };
}();
