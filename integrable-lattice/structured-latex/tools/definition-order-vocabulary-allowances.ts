/**
 * 散文の語の初出の全数走査の**免除表**。
 *
 * 走査は「名づけの言い回しの位置」を定義とみなす。この判定が拾えない形が実際にあるので、
 * **順序として正しいと人が読んで確かめたものだけ**をここへ理由つきで置く。
 * 理由を書けないものは免除しない（免除は本文を直さずに済ませる口実ではない）。
 */

export type VocabularySweepAllowance = { readonly reason: string };

export const VOCABULARY_SWEEP_ALLOWANCES: Readonly<
  Record<string, Readonly<Record<string, VocabularySweepAllowance>>>
> = {
  ja: {
    全域木数: {
      reason:
        "全域木の個数という概念は標準の語彙であり、本論文が定義しているのは記号 κ_n のほうである。" +
        "初出（双対命題 D）は Kataoka の実現可能性を論じる中で標準の語として使っており、" +
        "定義ブロックはその語に記号を与えている。cycle 28 step 2 が台帳へ載せないと決めた当のもので、" +
        "この走査はその判断を独立に再現している。",
    },
    付値: {
      reason:
        "p 進付値は標準の語彙で、序論から使われている。走査が名づけとみなした ℓ=2 族の" +
        "「3 つの項の付値を …:= と置く」は、語を定義しているのではなく個々の項に記号を与えている。",
    },
  },
  en: {
    number: {
      reason:
        "\"we define the number of periodic points\" の頭だけが残ったもの。" +
        "英語は名詞句を of で伸ばすので、走査は of の手前で切る。" +
        "一般名詞であって本論文が定義する語ではない（定義しているのは number of periodic points）。",
    },
    "eventual period": {
      reason:
        "列が最終的にもつ周期という一般の語で、命題 A が行列冪列について先に使っている。" +
        "本論文が定義するのは記号 π_tr（トレース列の最終周期）のほうであり、台帳はそちらを追う。",
    },
    "non-degenerate": {
      reason:
        "命題 C が「非退化な companion 行列」と別の意味で先に使っている。" +
        "台帳が単独の語ではなく non-degenerate tower という句で登録しているのと同じ理由で、" +
        "単独の語では追跡できない。",
    },
    reduction: {
      reason: "還元（mod ℓ を取る操作）は標準の語彙で、前の章から使われている。",
    },
    cancellation: {
      reason:
        "打ち消しという一般の語は読者向けの注意（第 1 章）で先に使われている。" +
        "命題 G″ が名づけているのは ℓ=2 族の分岐の名前であって、同じ字面の別の対象である。",
    },
  },
};
