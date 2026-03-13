async (page) => {
  const sleep = (ms) => page.waitForTimeout(ms);

  const topModules = [
    "工作台",
    "财务中心",
    "报表中心",
    "资产管理",
    "合同管理",
    "在线审批",
    "银农直联",
    "基层党建",
  ];

  const safeTabPattern = /(列表|录入|回收站|报表|明细|汇总|总账|余额|设置|流程|中心|管理|处理|统计|资产|合同|审批|配置|支付|接口|账户|党建|日志)/;

  const seen = new Set();
  const states = [];

  async function capture(label) {
    await sleep(300);
    const url = page.url();
    const title = await page.title();
    const mainText = await page
      .locator("main")
      .innerText()
      .catch(async () => page.locator("body").innerText());
    const buttons = await page.getByRole("button").allInnerTexts();
    const headings = await page.locator("main h1, main h2, main h3, main h4").allInnerTexts();
    const key = `${label}|${url}`;
    if (seen.has(key)) return;
    seen.add(key);
    states.push({
      label,
      url,
      title,
      buttons: buttons.map((x) => x.trim()).filter(Boolean),
      headings: headings.map((x) => x.trim()).filter(Boolean),
      text: (mainText || "").trim(),
    });
  }

  async function clickIfExistsByRole(name, exact = true) {
    const locator = page.getByRole("button", exact ? { name, exact: true } : { name });
    if ((await locator.count()) > 0) {
      await locator.first().click().catch(() => {});
      await sleep(500);
      return true;
    }
    return false;
  }

  function uniq(list) {
    return [...new Set(list)];
  }

  await page.goto("https://card-kite-76534082.figma.site", { waitUntil: "domcontentloaded" });
  await sleep(1200);
  await capture("ROOT");

  for (const moduleName of topModules) {
    await clickIfExistsByRole(moduleName);
    await capture(`MODULE:${moduleName}`);

    const navButtons = await page.locator("nav button").allInnerTexts();
    const normalized = navButtons.map((x) => x.trim()).filter(Boolean);
    const children = uniq(
      normalized.filter((t) => {
        if (topModules.includes(t)) return false;
        if (/^\d+$/.test(t)) return false;
        if (t.length > 18) return false;
        return true;
      }),
    );

    for (const child of children) {
      const clicked = await clickIfExistsByRole(child);
      if (!clicked) continue;
      await capture(`${moduleName}/${child}`);

      const inMainButtons = await page.locator("main button").allInnerTexts();
      const tabCandidates = uniq(
        inMainButtons
          .map((x) => x.trim())
          .filter((t) => t && t !== child && safeTabPattern.test(t))
          .filter((t) => !/(新增|删除|导出|打印|审批|审核|保存|提交|取消|拒绝|退回|还原|彻底删除)/.test(t)),
      );

      for (const tabName of tabCandidates) {
        const clickedTab = await clickIfExistsByRole(tabName);
        if (!clickedTab) continue;
        await capture(`${moduleName}/${child}/TAB:${tabName}`);
      }
    }
  }

  const corpus = states
    .map((s) => `${s.label}\n${s.text}\n${s.buttons.join(" ")}\n${s.headings.join(" ")}`)
    .join("\n\n");

  return {
    scannedViews: states.length,
    labels: states.map((s) => s.label),
    states,
    corpus,
  };
}
