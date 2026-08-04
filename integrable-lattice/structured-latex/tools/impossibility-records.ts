/**
 * **「書けない理由」の台帳**（cycle 38 step 5 で新設）。
 *
 * ## なぜこれが要るか
 *
 * cycle 37 の主題は「『書けない理由』として記録されていたものが 3 つとも誤りだった」ことで、
 * cycle 38 step 1 で 4 つめが出た。総括は「着手して初めて誤りと分かった」と書き、
 * **着手せずに疑える形があるかを測ること**を cycle 38 の焦点に挙げた。
 *
 * ## 測って分かったこと（本ファイルの根拠）
 *
 * 覆った記録を全数で読むと、どれも同じ 2 層でできている。
 *
 * | 層 | 中身 | 覆った回数 |
 * |---|---|---|
 * | **実測** | 「mathlib に X が無い」。走査ログが裏付ける | **0 回** |
 * | **推論** | 「だから、この段は書けない」 | **5 回**（試された回数と同じ） |
 *
 * **実測は 1 度も覆っていない。覆ったのは毎回そこから先の推論である。**
 * cycle 37 step 3 の記録がそれを 1 文で言っている——
 * 「行列の単因子が無いという実測そのものは正しく、誤っていたのは
 * 『だからこの段は書けない』という推論のほうである」。
 *
 * ## したがって、着手せずに疑える形はある
 *
 * **2 つの層を型で分け、推論の側に「自前で書く素材を探したか」を必ず書かせる。**
 * 素材が在ると分かっているものは、**書けないのではなく書いていないだけ**である。
 * そこを毎サイクル印字すれば、着手する前に候補が見える。
 *
 * cycle 37 step 1 は現にその形で書いていた——「Gauss 型の補題は無い（実測）。
 * **ただし素材そのものは在るので自前で書ける見込みはある**」。
 * **cycle 38 step 1 はその 1 行を読んで着手し、実際に書けた。**
 * つまりこの形は既に 1 度、着手前の判断材料として働いている。
 *
 * ## cycle 39 step 1 で 1 件が消えた。ただし予告は当たり方が違った
 *
 * この形が最初に挙げた候補（Newton 多面体の加法性）を cycle 39 step 1 が書いたので、
 * 記録から外した。**予告した「素材」は現に使えた**——`convexHull_add` はそのまま入った。
 * **しかしそれで済んだのは主張の片側だけである。そう書く。**
 * `convexHull_add` が与えるのは右辺の書き換えであって、証明の量の大半は逆向きの包含にあり、
 * そこは走査が挙げた素材とは関係のない組合せの議論だった。
 * **したがってこの形が予告できるのは「着手してよい」ことまでで、「どれだけ書けば済むか」ではない。**
 * cycle 38 総括はこの記録を「素材どころか主張の芯が在る」と書いたが、
 * 実際に書いてみると芯と呼べるのは半分だった。**着手前の見立てが実測より強く出た例である。**
 *
 * ## 限界（正直に書く）
 *
 * - **「素材を探した」と書いたかどうかしか見られない。** 探し方が十分だったかは人の判断である。
 * - **素材が在ることは「書ける」を予告するが、「書く量」は予告しない**（cycle 39 step 1 の実測）。
 * - **素材が無いと書いた記録が正しいかは、依然として着手するまで分からない。**
 *   塞げるのは「探さずに書けないと書く」道までである。
 * - 覆った回数 5 は**試された回数と同じ**なので、「推論はいつも誤り」ではなく
 *   **「試されたものは全部誤りだった」**としか言えない。標本はこちらが選んでいる。
 */

/** 実測の層（走査ログが裏付ける）。ここは 1 度も覆っていない。 */
export type AbsenceMeasurement = {
  /** 何が mathlib に無いと測ったか。 */
  readonly absent: string;
  /** 走査ログのファイル名（`lean/logs/` に実在することを確かめる）。 */
  readonly log: string;
};

/**
 * 推論の層。**自前で書く素材を探したかを型で必須にする。**
 * `素材あり` は「書けないのではなく書いていないだけ」を意味し、毎サイクル印字される。
 */
export type WritabilityInference =
  | {
      readonly kind: "素材あり";
      /** 実在を確かめる mathlib の宣言名（走査ログに現れることを確かめる）。 */
      readonly materials: readonly string[];
    }
  | {
      readonly kind: "素材も無い";
      /** 素材を探したこと自体の根拠（走査ログのファイル名）。 */
      readonly searchedLog: string;
    };

export type ImpossibilityRecord = {
  /** どの段について「書けない」と書いているか。 */
  readonly step: string;
  /** 台帳のどのエントリの話か（本文の主張の `block`、または外部定理の見出し）。 */
  readonly entry: string;
  readonly measurement: AbsenceMeasurement;
  readonly inference: WritabilityInference;
};

/**
 * **現に立っている「書けない理由」の全数**（2026-08-05 実測）。
 *
 * 覆ったものはここに残さない（覆った経緯は検査 F の台帳の散文にある）。
 * ここに在るのは、いま「書けない／書いていない」と言っている記録だけである。
 */
export const IMPOSSIBILITY_RECORDS: readonly ImpossibilityRecord[] = [
  {
    step: "多変数の Mahler 測度（自由エネルギー密度＝Mahler 測度のアルキメデス側）",
    entry: "paper_051_theorem_duality",
    measurement: {
      absent: "MvPolynomial の Mahler 測度（多変数版）",
      log: "mathlib-gap-survey-cycle38-materials.log",
    },
    // 1 変数版は在り（`Polynomial.mahlerMeasure`）、多変数版だけが無い。
    // 2026-08-05 に走査し直して確かめた（同じログの段 1）。
    inference: { kind: "素材あり", materials: ["mahlerMeasure", "mahlerMeasure_mul"] },
  },
  {
    step: "Skolem–Mahler–Lech の定理（線形回帰数列の零点集合）",
    entry: "Skolem–Mahler–Lech の定理（線形回帰数列の零点集合）",
    measurement: {
      absent: "SkolemMahlerLech / 語幹 `skolem mahler`",
      log: "mathlib-gap-survey-cycle31-external.log",
    },
    inference: { kind: "素材も無い", searchedLog: "mathlib-gap-survey-cycle31-external.log" },
  },
  {
    step: "Monsky の p 進冪級数の定理",
    entry: "Monsky の p 進冪級数の定理",
    measurement: {
      absent: "Monsky / 語幹 `monsky`、および岩澤代数の一般論",
      log: "mathlib-gap-survey-cycle31-external.log",
    },
    inference: { kind: "素材も無い", searchedLog: "mathlib-gap-survey-cycle31-external.log" },
  },
  {
    step: "Cuoco–Monsky の類数の漸近",
    entry: "Cuoco–Monsky の類数の漸近（$\\mathbb{Z}_p^d$ 拡大の岩澤型漸近）",
    measurement: {
      absent: "CuocoMonsky / 語幹 `cuoco`、岩澤不変量の漸近",
      log: "mathlib-gap-survey-cycle31-external.log",
    },
    inference: { kind: "素材も無い", searchedLog: "mathlib-gap-survey-cycle31-external.log" },
  },
];

/**
 * **覆った記録の全数**（実測値。`step` は覆したサイクルの step）。
 *
 * ここに在るのは「書けない」と書かれていて、着手したら書けたものである。
 * **どれも実測（mathlib に無い）は正しく、覆ったのは推論（だから書けない）だけである。**
 */
export const OVERTURNED_INFERENCES: readonly {
  readonly cycle: string;
  readonly what: string;
  readonly measurementHeld: boolean;
}[] = [
  {
    cycle: "cycle 29 step 3",
    what: "「整数行列の Smith 標準形が mathlib に無いから $w^*$ は書けない」——$w^*$ に整除の鎖は要らず、適合基底の係数の $p$ 進付値の最大値で書けた",
    measurementHeld: true,
  },
  {
    cycle: "cycle 35 step 2",
    what: "「可換環の上の Euler の双対基底公式は素材が無いから書けない」——$\\rho'(\\theta)$ で割らずに書けば分離性も体も要らなかった",
    measurementHeld: true,
  },
  {
    cycle: "cycle 36 step 2",
    what: "「頂点の型を固定しているので葉を取り除く帰納法は書けない」——頂点集合を引数に持つ形へ書き直したら通った",
    measurementHeld: true,
  },
  {
    cycle: "cycle 37 step 3",
    what: "「$p^{w^*}G^{-1}$ の段には行列の単因子が要るが mathlib に無いから書けない」——行列の単因子は要らず、部分加群の適合基底で足りた（cycle 19 から 18 サイクル持ち越し）",
    measurementHeld: true,
  },
  {
    cycle: "cycle 38 step 1",
    what: "「無平方性を $\\mathbb{Z}[x]$ から $\\mathbb{Q}[x]$ へ移す Gauss 型の補題が mathlib に無いから書けない」——同じログが名指しした素材から自前で 1 本書けた",
    measurementHeld: true,
  },
];
