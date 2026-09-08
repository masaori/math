# SageMath Check: epsilon_square_identity

## 対象

**対象ラベル**: `epsilon_square_identity` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`
- 範囲: 全スピン反転行列について `ε²=I` が成り立つこと

## チェック一覧

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_prefix_append_site_operator.sage` | 帰納法の仮定へ次のサイト作用素を右から掛ける | **PASS** | `M=1,…,5`、`r=0,…,M-1` の全帰納段で厳密等号 |
| `check_prefix_kronecker_multiplication.sage` | 帰納段でクロネッカー積の積を因子ごとの積へ直す | **PASS** | `M=1,…,5`、`r=0,…,M-1` の全帰納段で厳密等号 |
| `check_prefix_identity_simplification.sage` | 帰納段で `AI=IA=A` と `II=I` を適用する | **PASS** | `M=1,…,5`、`r=0,…,M-1` の全帰納段で厳密等号 |
| `check_site_product_equals_all_factors.sage` | 空積の初項を含む有限帰納法の各接頭積と終端を全因子のクロネッカー積へ直す | **PASS** | `M=1,…,5`、`r=0,…,M` の全接頭積で厳密等号 |
| `check_kronecker_product_multiplication.sage` | 二つのクロネッカー積の積を因子ごとの積へ直す | **PASS** | `M=1,…,5` で厳密等号 |
| `check_pauli_square_each_factor.sage` | 各因子へ `(σx)²=I₂` を適用する | **PASS** | `M=1,…,5` で厳密等号 |
| `check_kronecker_identity.sage` | 単位因子のクロネッカー積を `2^M` 次の単位行列へ直す | **PASS** | `M=1,…,5` で厳密等号 |

全成分を `QQ` 上に置き、有限帰納法の三つの式変形と終端、その後の二乗計算の四段を
一つの式変形につき一ファイルで検査した。複素数への包含前に
等号を決定できるため、浮動小数点と `RR` / `CC` への脱出はない。検査範囲は `M=1,…,5` の
有限例であり、一般の `M` に対する人手証明との一対一対応は Lean の `sigmaXPrefixProduct_eq_xString`、
`epsilon_eq_siteProd_pauliX_by_induction`、`epsilon_mul_self` が担う。Lean の
`NecSuf.prefix_terminal_mul_self` は不要な行列構造を除いた必要十分版である。固有値候補と二つの
固有空間の次元公式は対象に含めない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_square_identity
```

実行ログは `sagemath/check/epsilon_square_identity/logs/` に保存する。
