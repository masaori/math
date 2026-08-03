/**
 * **過去に実際に起きた転記事故の再現データ。**
 *
 * 「ツールがエラーを出さなかった」ことは、検査が効いていることの根拠にならない。
 * そこで、事故が起きていた頃の本文を**現在の本文へ適用する差分**として持ち、
 * 検査がそれを挙げることを `verify-transcription-detection-test.ts` が確かめる。
 *
 * **本文ファイル（`content/`）は書き換えない。** 読み込んだ後のメモリ上の値へ差分を当てるだけである
 * （本文は別 step の担当であり、触ってはならない）。
 *
 * 差分の文言は git の履歴から取った（事故時点のコミットと、それを直したコミット）:
 *   - cycle 18: 2d414ed が直した 命題 N の例外集合。直前の版が `find` 側である。
 *   - cycle 20: ac98013 が足した 命題 J (J1) の $A_1\equiv0$。足す前が `find` 側である。
 *   - cycle 21: 5c59660 が直した 命題 R (R1) の係数の添字。直す前が `find` 側である。
 */

import type { BlockView, Passage, SourceLink } from "./transcription-model.ts";

export type FixtureOp =
  | { op: "replaceProse"; find: string; replace: string }
  | { op: "dropProse"; find: string }
  | { op: "replaceFormula"; find: string; replace: string }
  | { op: "dropFormula"; find: string };

export type Fixture = {
  name: string;
  /** 事故が起きたサイクルと、そのときの一次情報。 */
  provenance: string;
  block: string;
  ops: readonly FixtureOp[];
  /** どの検査が、何を挙げれば「検出できた」と言えるか。 */
  expect: { check: "A" | "B"; contains: string };
};

export const FIXTURES: readonly Fixture[] = [
  {
    name: "cycle18: 命題 N の例外集合が「有限個の N」になっていた",
    provenance:
      "コミット 2d414ed が直した。根拠 report は outputs/reports/cycle3_T1_D-U2_rigorous.md で、" +
      "そこには「Skolem–Mahler–Lech 例外（算術級数の有限和）」と正しく書いてある。" +
      "算術級数の有限和は一般に無限集合なので、「有限個の N」は誤りである。",
    block: "paper_044_theorem_newton",
    ops: [
      {
        op: "replaceProse",
        find: "**ただし Skolem–Mahler–Lech 型の相殺により例外が生じる。**",
        replace: "**ただし Skolem–Mahler–Lech 型の相殺により、有限個の ",
      },
      { op: "dropProse", find: "例外集合は算術級数の有限和であり" },
      { op: "dropProse", find: "を取り違えたものである）。" },
      { op: "dropProse", find: "（cycle 18 の Lean 形式化で発見した本文の誤り" },
    ],
    expect: { check: "A", contains: "算術級数" },
  },
  {
    name: "cycle20: 桁定理（命題 J (J1)）が使う $A_1\\equiv0$ が本文に無かった",
    provenance:
      "コミット ac98013 が足した。根拠 report は outputs/reports/cycle19_T3_theta_ge_ell_plus_1.md の " +
      "定理 J2 の証明で、最後の等号が cycle 18 補題 A2 (1)（$A_1\\equiv0$）から従うと書いてある。" +
      "この仮定を落とすと $m=\\ell^L$ ちょうどの段は偽になる（本文に反例が入っている）。" +
      "**cycle 25 step 4a で本文へ証明が入り、$A_1$ は statement だけでなく proof にも現れるようになった。** " +
      "事故を再現するには**ブロック全体から**この仮定を落とす必要があるので、" +
      "差分の対象を `A_1\\equiv0` ちょうどから `A_1` を含む数式すべてへ広げた" +
      "（`A_1\\equiv0` だけを落とすと proof 側の $A_1=0$・$\\overline{A_1(u,v)}=0$ が残り、" +
      "検査は「本文にある」と正しく判定して赤にならない）。",
    block: "paper_091_theorem_theta_padic",
    ops: [{ op: "dropFormula", find: "A_1" }],
    expect: { check: "A", contains: "A_{1}" },
  },
  {
    name: "cycle21: 命題 R (R1) の係数が添字なしの $\\mu$ になっていた",
    provenance:
      "コミット 5c59660 が直した。根拠 report は outputs/reports/cycle20_T3_cancellation_recursion.md で、" +
      "係数は指数 $\\gamma$ ごとに決まる族である（$\\mu_\\gamma$）。" +
      "桁 $c$ の枝では $\\gamma$ 番目の係数が $\\mu_{c+\\ell\\gamma}$ になる。",
    block: "paper_101_theorem_digit_branch",
    ops: [{ op: "replaceFormula", find: "\\mu_{c+\\ell\\gamma}", replace: "\\mu" }],
    expect: { check: "B", contains: "\\mu" },
  },
];

// --- 免除の腐り（cycle 24 step 3） -----------------------------------------------

/**
 * **免除が腐った状態の再現データ。**
 *
 * 検査 A′（免除の根拠が生きているか）が実際に赤くなることを確かめるために、
 * 「根拠が動いた免除」を人工的に作る。**ファイルは 1 バイトも書き換えない**——
 * 台帳・本文・report を読み込んだ後のメモリ上の値へ差分を当てる。
 *
 * 腐り方は**型ごとに違う**ので、型ごとに 1 件以上を用意する。
 */
export type ExemptionRot = {
  name: string;
  /** その腐り方が実際に起こりうる根拠（予定されている変更など）。 */
  provenance: string;
  block: string;
  item: string;
  mutate:
    | { kind: "reportEdited"; find: string; replace: string }
    | { kind: "quotePointsElsewhere"; reportQuote: string }
    | { kind: "bodyLostQuote" }
    | { kind: "holderLostItem" }
    | { kind: "holderGone" }
    | { kind: "refRecordGone" }
    | { kind: "quoteTooShort" };
  /** 期待する違反の種類。 */
  expect: string;
};

export const EXEMPTION_ROTS: readonly ExemptionRot[] = [
  {
    name: "根拠 report の文が書き換わった（cycle 24 step 1 が実際に 8 件の訂正を入れた）",
    provenance:
      "cycle 24 step 1（`cycle24_ops_fix_grounding_reports.md`）は定理 D2 の最後の一文（偽）・" +
      "定理 D3/D5 の $v_\\ell(0)$ 規約など 8 件を実際に訂正した。" +
      "訂正で根拠の文が書き換われば、その文に寄りかかった免除は判定し直しになる。",
    block: "paper_044_theorem_newton",
    item: "スパイク",
    mutate: {
      kind: "reportEdited",
      find: "でスパイクしうる",
      replace: "で成長率が跳ぶことがある",
    },
    expect: "根拠の引用が report に無い",
  },
  {
    name: "引用は当たるが、その文はその項目を生まない（引用と項目の対応が壊れた）",
    provenance:
      "cycle 23 step 2 の誤り 8.2（根拠 report の選び方を間違え、判定語ばかりを照合させた）と同じ型の壊れ方。" +
      "別の文を根拠として貼っても、自然文の理由だけでは誰も気付けない。",
    block: "paper_041_theorem_periodicity",
    item: "前周期",
    // 同じ report の別の条件文（実在する）へ付け替える。引用としては当たるが、
    // その文は「前周期」を生まないので、根拠になっていない。
    mutate: { kind: "quotePointsElsewhere", reportQuote: "(4) 有限計算。" },
    expect: "根拠の文からその項目が出ない",
  },
  {
    name: "免除が「本文はこう書いている」と言っている記述が、本文から消えた",
    provenance:
      "cycle 24 step 4 は本文へ定理 G4・D 系列を反映する。本文の書き換えで、免除が寄りかかっていた" +
      "記述（記法の選択・言い換え・弱い主張・例示の省略の相手側）が消えることは実際に起こる。",
    block: "paper_063_theorem_W",
    item: "\\dfrac",
    mutate: { kind: "bodyLostQuote" },
    expect: "根拠として指した本文の記述が本文に無い",
  },
  {
    name: "「別のブロックが持っている」と言っている分担先が、それを失った",
    provenance:
      "分担（division）は、論文全体で見れば内容が残っていることを根拠に落としている。" +
      "分担先が落とせば、論文全体からその内容が消える。**どのブロックも自分の担当だけを見ているので、誰も気付かない。**",
    block: "paper_013_remark_four_axes",
    item: "\\Omega",
    mutate: { kind: "holderLostItem" },
    expect: "分担先のブロックがその項目を持っていない",
  },
  {
    name: "「本文が直すべきものとして記録済み」の記録が消えた",
    provenance:
      "cycle 23 step 2 は本文の不備 1 件を免除で通したが、理由は「report に記録済みだから」である。" +
      "記録が消えれば、それはただの黙殺になる。",
    block: "paper_032_remark_ising_known",
    item: "本文未読",
    mutate: { kind: "refRecordGone" },
    expect: "参照先の記録が見つからない",
  },
  {
    name: "「report のほうが古い」の、解消した側の記録が消えた",
    provenance:
      "reportStale は 2 本の report の**前後関係**に寄りかかっている。解消した側が動けば判定は無効になる。",
    block: "paper_081_remark_scope",
    item: "未確認",
    mutate: { kind: "refRecordGone" },
    expect: "参照先の記録が見つからない",
  },
  {
    name: "分担先のブロックそのものが本文から消えた",
    provenance:
      "本文の再編でブロックが統合・削除されることは実際にある（cycle 24 step 4 が本文を再編する）。" +
      "分担先が消えれば、その免除は宙に浮く。",
    block: "paper_021_definition_curve",
    item: "有限計算",
    mutate: { kind: "holderGone" },
    expect: "分担先のブロックが本文に無い",
  },
  {
    name: "引用が report の複数の文に当たる（どの文が根拠か特定できない）",
    provenance:
      "「(H) を仮定し、塔が**非退化**」のような定型句は report の中で何度も出る（定理 N1 と定理 N2）。" +
      "複数に当たる引用は「その文が動いたら落ちる」という pin になっていないので、根拠として認めない。",
    // cycle 27 step 1 まではこの再現データは同じブロックの免除「仮定」を使っていた。
    // その免除は、本文へ (G6) の $\min\emptyset$ の規約を入れた際に「仮定」の語が本文へ現れて失効し、
    // 台帳から消えた（**免除が余れば赤くなる**という設計どおりの動き）。
    // 再現データが生きた台帳を引いているので、同じブロックの現存する免除へ付け替える。
    // 差分の種類（引用が report の複数の文に当たる）は変えていない。
    block: "paper_053_theorem_lower_order",
    item: "同値",
    mutate: { kind: "quotePointsElsewhere", reportQuote: "(H) を仮定し、塔が**非退化**" },
    expect: "根拠の引用が report の複数の文に当たる",
  },
  {
    name: "根拠が短すぎて何も pin していない（移行で実際に 1 件出た）",
    provenance:
      "cycle 24 step 3 の移行中、エントロピー＝Mahler 測度のブロックの免除「無条件」で 10 文字の引用を書き、" +
      "この検査に実際に止められた（`cycle24_ops_exemption_rot_guard.md` の移行の節）。" +
      "短い引用は report の別の箇所にも当たりうるので、pin として機能しない。",
    block: "paper_052_theorem_l0_computable",
    item: "同値",
    mutate: { kind: "quoteTooShort" },
    expect: "根拠の指定が短すぎて何も pin していない",
  },
];

/** 差分を当てる。1 つでも当たらなければ例外（再現データが腐ったまま緑になるのを防ぐ）。 */
export function applyFixture(
  view: { proseParts: string[]; prose: string; formulas: string[] },
  fixture: Fixture,
): { proseParts: string[]; prose: string; formulas: string[] } {
  let proseParts = [...view.proseParts];
  let formulas = [...view.formulas];
  for (const op of fixture.ops) {
    let hits = 0;
    if (op.op === "replaceProse") {
      proseParts = proseParts.map((part) => {
        if (!part.includes(op.find)) return part;
        hits += 1;
        return part.replaceAll(op.find, op.replace);
      });
    } else if (op.op === "dropProse") {
      const kept = proseParts.filter((part) => !part.includes(op.find));
      hits = proseParts.length - kept.length;
      proseParts = kept;
    } else if (op.op === "replaceFormula") {
      formulas = formulas.map((tex) => {
        if (!tex.includes(op.find)) return tex;
        hits += 1;
        return tex.replaceAll(op.find, op.replace);
      });
    } else {
      const kept = formulas.filter((tex) => !tex.includes(op.find));
      hits = formulas.length - kept.length;
      formulas = kept;
    }
    if (hits === 0) {
      throw new Error(
        `再現データが現在の本文に当たらない: ${fixture.name} / ${op.op} "${op.find}"。` +
          "本文が書き換わったなら再現データも更新すること（当たらないまま緑にしない）。",
      );
    }
  }
  return { proseParts, prose: proseParts.join(" "), formulas };
}

/**
 * 免除の腐りを当てる。**ファイルは書き換えず**、検査 A′ に渡す 4 つの入力
 * （台帳・本文ブロック・report の該当範囲・全ブロック）のメモリ上の複製へ差分を当てる。
 *
 * 当たらなければ例外（腐らせたつもりで何も変えていない、という緑を防ぐ）。
 */
export function applyExemptionRot(
  rot: ExemptionRot,
  link: SourceLink,
  view: BlockView,
  passageLines: readonly { passage: Passage; lines: string[] }[],
  blocks: ReadonlyMap<string, BlockView>,
): {
  link: SourceLink;
  view: BlockView;
  passageLines: { passage: Passage; lines: string[] }[];
  blocks: Map<string, BlockView>;
} {
  const entry = link.acknowledged.find((a) => a.item === rot.item);
  if (entry === undefined) throw new Error(`免除が台帳に無い: ${rot.block} / ${rot.item}`);
  const g = entry.grounds;
  let nextLink = link;
  let nextView = view;
  let nextPassages = passageLines.map((p) => ({ passage: p.passage, lines: [...p.lines] }));
  const nextBlocks = new Map(blocks);

  const replaceGrounds = (grounds: typeof g): void => {
    nextLink = {
      ...link,
      acknowledged: link.acknowledged.map((a) => (a.item === rot.item ? { ...a, grounds } : a)),
    };
  };
  const strip = (target: BlockView, needle: string): BlockView => {
    let hits = 0;
    const proseParts = target.proseParts.map((part) => {
      if (!part.includes(needle)) return part;
      hits += 1;
      return part.replaceAll(needle, "");
    });
    const formulas = target.formulas.map((tex) => {
      if (!tex.includes(needle)) return tex;
      hits += 1;
      return tex.replaceAll(needle, "");
    });
    if (hits === 0) throw new Error(`本文に "${needle}" が無いので腐らせられない: ${rot.name}`);
    return { ...target, proseParts, prose: proseParts.join(" "), formulas };
  };

  if (rot.mutate.kind === "reportEdited") {
    const { find, replace } = rot.mutate;
    let hits = 0;
    nextPassages = nextPassages.map((p) => ({
      passage: p.passage,
      lines: p.lines.map((line) => {
        if (!line.includes(find)) return line;
        hits += 1;
        return line.replaceAll(find, replace);
      }),
    }));
    if (hits === 0) throw new Error(`report に "${find}" が無いので腐らせられない: ${rot.name}`);
  } else if (rot.mutate.kind === "quotePointsElsewhere") {
    replaceGrounds({ ...g, reportQuote: rot.mutate.reportQuote });
  } else if (rot.mutate.kind === "quoteTooShort") {
    replaceGrounds({ ...g, reportQuote: g.reportQuote.slice(0, 6) });
  } else if (rot.mutate.kind === "bodyLostQuote") {
    if (!("bodyQuote" in g)) throw new Error(`bodyQuote を持たない型: ${g.type}`);
    nextView = strip(view, g.bodyQuote);
  } else if (rot.mutate.kind === "holderGone") {
    if (g.type !== "division") throw new Error(`division ではない: ${g.type}`);
    if (!nextBlocks.delete(g.holder)) throw new Error(`分担先が無い: ${g.holder}`);
  } else if (rot.mutate.kind === "holderLostItem") {
    if (g.type !== "division") throw new Error(`division ではない: ${g.type}`);
    const holder = blocks.get(g.holder);
    if (holder === undefined) throw new Error(`分担先が無い: ${g.holder}`);
    nextBlocks.set(g.holder, strip(holder, g.holderItem));
  } else {
    if (g.type === "reportStale") replaceGrounds({ ...g, supersededBy: { ...g.supersededBy, marker: g.supersededBy.marker + "（この行は消えた）" } });
    else if (g.type === "bodyDefect") replaceGrounds({ ...g, recordedIn: { ...g.recordedIn, marker: g.recordedIn.marker + "（この行は消えた）" } });
    else throw new Error(`参照先を持たない型: ${g.type}`);
  }
  return { link: nextLink, view: nextView, passageLines: nextPassages, blocks: nextBlocks };
}
