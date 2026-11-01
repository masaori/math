# SageMath Check: polar_multiplication_well_defined

## 対象

**対象ラベル**: `polar_multiplication_well_defined` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_polar_multiplication_well_defined`（極座標表現の積は代表元の取り方によらない）
- 範囲: 主張と、証明の場合 (a)・場合 (b) の三つの鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 場合 (a) `rr' = 0 = r̃r̃'`、場合 (b) の角度の鎖 `(θ+θ')-(θ̃+θ̃') = (θ-θ̃)+(θ'-θ̃') = 2nπ+(θ'-θ̃') = 2nπ+2n'π = 2(n+n')π` と半径の鎖 `rr' = r̃r' = r̃r̃'` | `check_case_chains.sage` | 一般の点で、各行の両辺を別の式から作り、その行が根拠に挙げる仮定だけを代入して多項式として比べる。対照として、角度の鎖の第二行は仮定なしでは等しくないこと | **PASS** | 一般の点 |
| 主張 | `check_statement.sage` | 具体の点で、代表元の組と同値な別の代表元の組の全てについて、積の代表元が同値であること。場合 (b) では角度の差が `2(n+n')π` に等しいこと。対照として、角度を `π` だけずらした代表元では積が同値でないこと | **PASS** | 1156 組（場合 (a) 372、場合 (b) 784） |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。共通の準備は `sagemath/_shared/polar_representation.sage`。

- **一般の点**: 半径・角度・整数 `n, n'`・`π` を `QQ` 上の不定元とする多項式環。
  多項式として等しいことは、不定元にどの実数を入れても等しいことを含む。
- **具体の点**: 半径は `AA`（実代数的数）の非負の元（`0`、`1`、`2`、`1/5`、`√2`、`∛3`、`10^6`）。
  角度は `a + bπ`（`a, b ∈ QQ`）の形の実数で、`QQ` 上の一変数多項式環の一次以下の元として持つ。
  `π` は無理数なので `a + bπ = a' + b'π ⟺ (a,b) = (a',b')` であり、角度の等号・和・差・符号反転と、
  角度の同値 `θ ∼_angle θ' ⟺ ∃ n ∈ Z, θ-θ' = 2nπ`（差の定数項が `0` で `π` の係数の半分が整数）が厳密に判定できる。
  極座標表現の同値は定義 `polar_equivalence_class` の式どおり `r = r' = 0 ∨ (r = r' ∧ θ ∼_angle θ')` で判定し、
  類の等号はこの判定で確かめた。

主張の半径・角度は `R` の元であり、`AA` や `a + bπ` に入らない点は検算の範囲外で、人手証明が担う。

場合 (b) の半径の鎖 `rr' = r̃r' = r̃r̃'` は仮定を代入するだけの行で、本文の行が仮定どおりに写されているかの確認に留まる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh polar_multiplication_well_defined
```

実行ログは `sagemath/check/polar_multiplication_well_defined/logs/` に保存する。
