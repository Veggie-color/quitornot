const SITE_URL = "https://www.quitornot.click/";

Page({
  data: {
    src: SITE_URL
  },

  onShareAppMessage() {
    return {
      title: "辞了么 · 离职模拟器",
      path: "/pages/index/index"
    };
  }
});
