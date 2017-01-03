const extend = require('extend');
const extras = require('sassdoc-extras');
const swig = new require('swig');
const swigExtras = require('swig-extras');
const themeleon = require('themeleon')().use('consolidate');

swigExtras.useFilter(swig, 'split');
swigExtras.useFilter(swig, 'trim');
swigExtras.useFilter(swig, 'groupby');

const theme = themeleon(__dirname, function (t) {
  t.copy('assets');
  t.swig('views/index.swig', 'index.html');
});

module.exports = function (dest, ctx) {
  const def = {
    display: {
      access: ['public', 'private'],
      alias: false,
      watermark: true,
    },
    groups: {
      'undefined': 'General',
    }
  };

  ctx.view = extend(require('./view.json'), ctx.view);
  ctx.groups = extend(def.groups, ctx.groups);
  ctx.display = extend(def.display, ctx.display);
  ctx = extend({}, def, ctx);

  extras.markdown(ctx);
  extras.display(ctx);
  extras.groupName(ctx);

  ctx.data.byGroupAndType = extras.byGroupAndType(ctx.data);
  return theme.apply(this, arguments);
};
