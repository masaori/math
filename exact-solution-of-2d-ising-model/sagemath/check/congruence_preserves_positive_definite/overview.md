# SageMath Check: congruence_preserves_positive_definite

## 対象

**対象ラベル**: `congruence_preserves_positive_definite` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_claim_congruence_preserves_positive_definite`（左逆行列をもつ B による B^*(AB) は正定値）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 `((B^*)^*)_kl = B_kl` の 6 行 | `check_preparation_and_hermitian.sage` | `B` の成分を不定元の対に置き、`n = 1,…,4` の全成分で隣り合う行が等しい | **PASS** | 全て厳密に PASS |
| 準備 `(B'0)_k = 0_k` の 5 行 | 同上 | `B'` の成分を不定元の対に置いて確かめた | **PASS** | 同上 |
| エルミート性の 5 行 | 同上 | `A` をエルミートな不定元の表、`B` を一般の不定元の表に置いて隣り合う行列が等しい。両端を Sage と比べた | **PASS** | 同上 |
| `x = Ix = (B'B)x = B'(Bx)` の 3 行と `Bx ≠ 0` | `check_positivity.sage` | 具体の可逆な `QQ(i)` の行列 `B`、`B' := B^{-1}`（`B'B = I` を本文の積で確かめた）、零でない `x` で確かめた | **PASS** | 同上 |
| 正値性の 2 行と主張 | 同上 | `A = C^*C + I`（Sage の `is_positive_definite` で正定値を別に確かめた）で、`x^*(B^*(AB))x = (Bx)^*A(Bx)` が `(r, 0)`（`r > 0`）であること、Sage の `x̄ᵀ(B^*AB)x` と一致すること、Sage で `B^*AB` が正定値であることを確かめた（`n = 1,…,4`、各 4 組、各 6 本の `x`） | **PASS** | 同上 |
| 仮定が要ること | 同上 | 非可逆な `B` では `B^*AB` が正定値でないことを確かめた | **PASS** | 同上 |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。ℂ は本文 `definition_of_cc` どおり実数の対で持ち（`_shared/complex_as_real_pairs.sage`）、行列・数ベクトル・`x^*Ay` は本文の定め方どおりに成分から組んだ（`_shared/hermitian_forms_by_definition.sage`）。一般の等式は成分を `QQ` 上の多項式環の不定元に置いて確かめた。不定元で成り立つ多項式の等号は、実数を代入しても成り立つ。 正値性の段は具体の `QQ(i)` の行列で、値が `(r, 0)` かつ `r > 0` であることを `QQ` で判定した。

両辺を同じ式から作らないため、鎖の両端は、対 `(a, b)` を `QQ(i)` 係数の `a + ib` へ送った Sage の行列・ベクトルの `conjugate_transpose`・積・和と比べた。

## 確かめられない行と理由

背理法の行 `B'(Bx) = B'0` は仮定 `Bx = 0` を使うが、可逆な `B` では `Bx = 0` となる零でない `x` が無いので、代入の行そのものは確かめられない。代わりに、その前後の等号と結論 `Bx ≠ 0` を確かめた。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh congruence_preserves_positive_definite
```

実行ログは `sagemath/check/congruence_preserves_positive_definite/logs/` に保存する。
