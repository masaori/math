# Onsager 閉形式を既存の極限と同定し臨界点へ接続する

## 概要

有限モード和から得た積分を現在の変数 `x` と正規化で Onsager 閉形式として明記し、既存の周期境界自由エントロピー密度と同定する。さらに分散の隙間が閉じる点が、既に代数的に定義した唯一の正の Kramers--Wannier 不動点であることを証明する。

## 背景・前提

- モード和から積分へのタスクに依存する。
- `def_periodic_free_energy_density_le_one`, `def_critical_point`, `claim_kw_self_dual_quadratic_equivalence`, `claim_self_dual_positive_root_unique` を使う。
- 着手前に対象プロジェクトの README、MEMORY、CLAUDE.md、`docs/context/` を読むこと。

## スコープ

閉形式との同定、臨界点の位置、非解析性の発生箇所を扱う。臨界指数の一般論へは広げない。

## 記号の帰属と ℝ 脱出の見込み

- 臨界点 `x_c` と分散零条件は `Qbar` で決まる。
- 積分値と非解析性は `R` に住み、積分・局所極限・実関数の解析性を理由として脱出する。

## 作業内容

### 閉形式の同定

- 現在の `Z_L(x)=Σσ x^{m(σ)}` の規約から前因子を導き、外部式を変数変換だけで貼り付けない。
- 積分表示が `def_periodic_free_energy_density_le_one` で定義済みの同じ実数に等しいことを証明する。

### 自己双対点と特異性

- 分散因子の零条件を代数的に `ξ²+2ξ-1=0` へ同値変形する。
- `1+ξ≠0` を先に証明してから `claim_kw_self_dual_quadratic_equivalence` を適用する。
- 正錐での一意性により `ξ=x_c` を得て、臨界点の位置が可算側、非解析性が実数側にあることを分離する。

## 対象ファイル

- `exact-solution-of-2d-ising-model-lambda/structured-latex/content/main-text.ts`

## 完了条件

- [ ] 正規化済みの Onsager 積分表示が本文の主定理として証明されている。
- [ ] 既存の自由エントロピー密度との等号が証明されている。
- [ ] 分散零点、二次方程式、KW 不動点、正錐での一意性が前提を落とさず鎖になっている。
- [ ] 臨界点の代数的位置と非解析性の実数的主張が別ブロックである。
- [ ] 本文・SageMath linkage・Lean・PDF の全検証が通る。
