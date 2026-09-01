# 章 014「偶セクターでの `T` の作用」の Lean 形式化で見つかったこと

- 対象: `structured-latex/content/014_even_sector_T_action.ts`（10 主張）
- 発見経緯: Lean 形式化（具体版 `lean/Ising2D/Part014/`、抽象版 `lean/Ising2D/Abstract/TVActionSandwich.lean`）
- 結論から言うと、**本文の主張に誤り・穴は見つからなかった**。10 主張すべてを、
  係数まで原文どおりに形式化して閉じた（`sorry` / `admit` はゼロ）。
- 詳細な定理一覧・2 本立ての対応表は `lean/docs/ch014-formalization.md` にある。
  本ファイルはそのうち**本文（`structured-latex/`）に関わる指摘**だけを抜き出したものである。
  本タスクの方針どおり `structured-latex/` は一切編集していない。

---

## (a) 本文の主張が必要以上に強い箇所（誤りではない）

本文は本章の主張をすべて `μ ∈ 𝓜̌ = {1,…,M}` について述べているが、
Lean 側の定理はいずれも `μ : ℤ` 全体で証明できた。`𝓜̌` に絞る必要があるのは
反交換関係を `δ_{ν,M+1-μ}` の形で述べるとき（章 013）だけで、本章の主張には
`𝓜̌` に固有の性質が一切使われていない。

一次情報: `lean/Ising2D/Part014/Claim010_TVPlusAction.lean` の
`Ising2D.TVPlus_checkZ_checkY` の statement は `μ : ℤ` を全称量化しており、
`μ ∈ 𝓜̌` の仮定を取っていない。

本文の主張は `μ ∈ 𝓜̌` を代入すれば直ちに従うので、**本文が誤っているわけではない**。
（同種の観察を章 015 の `gamma_2_theta_tilde_nonzero` についても
`014_ch015-formalization-findings.md` に記録してある。）

## (b) 章 008 で既知だった 2 つの穴が、本章では本文の側で埋まっている

`lean/README.md`「形式化の過程で見つかった原文の問題」に記録済みの章 008 の指摘のうち、
次の 2 件は本章の本文では解消されている。

| 章 008 の指摘 | 本章での状況 |
| --- | --- |
| `B_1B_2B_1 = A(θ)` に双対関係の帰結 `c_2^* = s_2^* c_2` が要るのに、原文がどこにも書いていない | 本章の `factorization_of_A_theta_general` の proof は Step 4 で `duality_c2_star_eq_s2_star_c2` を**明示的に引用している** |
| `(V_1^{(±)})^{1/2}` を「`exp(iK_1H_1^{(±)})` の `1/2` 乗」と書き、proof 中で `exp((i/2)K_1H_1^{(±)})` に読み替えていた | 本章は `def_V1_plus_square_root` で最初から `exp((i/2)K_1H_1^{(+)})` を定義とし、それが平方根であることを `V1_plus_square_root_property` で示している |

## (c) 形式化の側に残る仮定（本文の穴ではない）

Lean 側は次の 2 つを仮定として渡している。いずれも章 008 と同じもので、
**数学的に必要な前提**であり、未形式化に由来する穴ではない。

1. `hdual : s_2^* c_2 = c_2^*`（双対関係 `sinh 2K_2 · sinh 2K_2^* = 1` の帰結）。
   上記 (b) のとおり本文もこれを明示的に引用している。
2. `IsingConst` の 5 成分が `K_1, K_2^*` の双曲線関数であること（`hc1 : c_1 = cosh 2K_1` 等）。
   本文が記号の定義（`def_transfer_matrix_symbols`）として置いているもので、
   Lean の `IsingConst` は 5 個の実数を保持するだけなので仮定として渡す。

## (d) 抽象版で確認できた、本文の観察の裏づけ

本文 `evensectorT_000_remark_overview` は「章 008 の各証明は `θ_μ` に固有の性質
（`e^{-iMθ_μ} = +1`、添字集合 `𝓜` の形、`M` 周期性）を使っていない」と述べている。
これは**正しい**。抽象版 `Ising2D.Abstract.actsBy_sandwich` から、
章 008 の結論（整数運動量版）を導き直せることを
`Ising2D.TV_hatZ_hatY_via_sandwich`（`Part014/Claim010_TVPlusAction.lean`）で確認した。
`αβ = s^2` の検証に使うのは `e^{-iθ}e^{iθ} = 1` と `i^2 = -1` の 2 つだけで、
`θ` が `2πμ/M` か `2π(μ-1/2)/M` かは効いていない。
