# SageMath Check: inverse_in_polar_representation

## 対象

**対象ラベル**: `inverse_in_polar_representation` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_inverse_in_polar_representation`（極座標表現の半径が正の元は両側の逆元をもつ）
- 範囲: 主張（`c = [(1/r,-θ)]` が両側から掛けて `e` になる）と、証明の二つの鎖（各四行）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `r ≠ 0 ⟹ r > 0`、`1/r ∈ R_{>0}`、存在の二つの鎖 | `check_existence.sage` | 一般の点で有理関数体の等式 `r·(1/r) = 1` と多項式環の `θ+(-θ) = 0`。具体の点で、各行の代表元を成分から別々に組み立て、隣どうしを比べる。対照として、角度の符号を反転しないと `e` にならないこと | **PASS** | 一般の点と 7 元 |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。共通の準備は `sagemath/_shared/polar_representation.sage`。

- **一般の点**: 半径・角度・整数 `n, n'`・`π` を `QQ` 上の不定元とする多項式環と、その有理関数体（`1/r` の行）。
  多項式として等しいことは、不定元にどの実数を入れても等しいことを含む。
- **具体の点**: 半径は `AA`（実代数的数）の非負の元（`0`、`1`、`2`、`1/5`、`√2`、`∛3`、`10^6`）。
  角度は `a + bπ`（`a, b ∈ QQ`）の形の実数で、`QQ` 上の一変数多項式環の一次以下の元として持つ。
  `π` は無理数なので `a + bπ = a' + b'π ⟺ (a,b) = (a',b')` であり、角度の等号・和・差・符号反転と、
  角度の同値 `θ ∼_angle θ' ⟺ ∃ n ∈ Z, θ-θ' = 2nπ`（差の定数項が `0` で `π` の係数の半分が整数）が厳密に判定できる。
  極座標表現の同値は定義 `polar_equivalence_class` の式どおり `r = r' = 0 ∨ (r = r' ∧ θ ∼_angle θ')` で判定し、
  類の等号はこの判定で確かめた。

主張の半径・角度は `R` の元であり、`AA` や `a + bπ` に入らない点は検算の範囲外で、人手証明が担う。

次の行は確かめ方が限られる。存在の鎖の最初の行（積の定義）は、本文の行が定義どおりに写されているかの確認に留まる。
`r·(1/r) = 1` と `θ+(-θ) = 0` の行は、`R` の公理の具体例を確かめるに留まる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh inverse_in_polar_representation
```

実行ログは `sagemath/check/inverse_in_polar_representation/logs/` に保存する。
