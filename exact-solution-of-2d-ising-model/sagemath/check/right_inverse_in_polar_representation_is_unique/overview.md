# SageMath Check: right_inverse_in_polar_representation_is_unique

## 対象

**対象ラベル**: `right_inverse_in_polar_representation_is_unique` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_right_inverse_in_polar_representation_is_unique`（極座標表現の半径が正の元に右から掛けて単位元になる元はただ一つ）
- 範囲: 主張（`a = [(r,θ)]`、`r ≠ 0` について、`a·b = e` を満たす `b ∈ (極座標表現)` は `c = [(1/r,-θ)]` に限る）と、証明の鎖 `b = e·b = (c·a)·b = c·(a·b) = c·e = c`

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 主張、鎖の仮定を使わない四つの行（`b = e·b`、`e·b = (c·a)·b`、`(c·a)·b = c·(a·b)`、`c·e = c`）、仮定を使う行 `c·(a·b) = c·e` | `check_uniqueness.sage` | `r ≠ 0` の各元 `a` について、`(極座標表現)` の候補の有限集合（標本の全ての元（半径零を含む）、`c` とその別の代表元、`c` を少しずらしたもの）の全てで、主張「`a·q ∼ e`」⟺「`q ∼ c`」と、仮定を使わない四つの行（結合律の行は代表元の段でも一致）。仮定を使う行は、条件を満たす候補で成り立ち、満たさない候補で成り立たないこと | **PASS** | 7 元、候補 112 個（うち条件を満たすもの 31 個） |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。共通の準備は `sagemath/_shared/polar_representation.sage`。

- **具体の点**: 半径は `AA`（実代数的数）の非負の元（`0`、`1`、`2`、`1/5`、`√2`、`∛3`、`10^6`）。
  角度は `a + bπ`（`a, b ∈ QQ`）の形の実数で、`QQ` 上の一変数多項式環の一次以下の元として持つ。
  `π` は無理数なので `a + bπ = a' + b'π ⟺ (a,b) = (a',b')` であり、角度の等号・和・差・符号反転と、
  角度の同値 `θ ∼_angle θ' ⟺ ∃ n ∈ Z, θ-θ' = 2nπ`（差の定数項が `0` で `π` の係数の半分が整数）が厳密に判定できる。
  極座標表現の同値は定義 `polar_equivalence_class` の式どおり `r = r' = 0 ∨ (r = r' ∧ θ ∼_angle θ')` で判定し、
  類の等号はこの判定で確かめた。

主張の半径・角度は `R` の元であり、`AA` や `a + bπ` に入らない点は検算の範囲外で、人手証明が担う。

鎖は単位元と結合律（`monoid_of_polar_representation`）と `c·a = e`（`inverse_in_polar_representation`）と仮定 `a·b = e` だけから従う。仮定を使わない行は、条件を満たさない候補を含めて確かめたので、仮定に頼らず成り立つことを見ている。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh right_inverse_in_polar_representation_is_unique
```

実行ログは `sagemath/check/right_inverse_in_polar_representation_is_unique/logs/` に保存する。
