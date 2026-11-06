# SageMath Check: epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors

## 対象

**対象ラベル**: `epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `maxeig_claim_epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors`（`ε_ℝx = x ⟺ ι(x) ∈ 𝓕^{(+)}`）
- 範囲: 定義 `def_epsilon_real` の `((ε_ℝ)_kl)_ℂ = ε_kl`、証明の (⇒) の 2 行の鎖 `ει(x) = ι(ε_ℝx) = ι(x)`、
  (⇐) の 2 行の鎖 `ι(ε_ℝx) = ει(x) = ι(x)` と `real_vector_inclusion_is_injective` による結び、主張の同値。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `def_epsilon_real`、(⇒) の鎖（`real_vector_inclusion_intertwines_matrix_vector_product`、仮定）、(⇐) の鎖（同、仮定と `def_even_eigenvectors_of_epsilon`）と単射性、主張 | `check_proof_lines.sage` | `M_col ∈ {1,2,3}` で `ε = σ^x⊠⋯⊠σ^x` から `ε_ℝ` を作り全成分で `((ε_ℝ)_kl)_ℂ = ε_kl` を確かめる。成分が `-1, 0, √2, √8/2` の実数のベクトル（`M_col = 3` は `-1, 0, √2` から、非零成分 3 個以下）849 個で、準備の交換 `ει(x) = ι(ε_ℝx)` を全部で、2 本の鎖を仮定を満たすもので、同値を全部で比べる。否定コントロール 2 件（`M_col = 2, 3`。`ε` の代わりに巡回置換を掛けると固定されない） | **PASS** | 固定される 51 個・固定されない 798 個で成り立つ |

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- `iota`・`rmatvec`・`cmatvec` は定義の式そのもので作る。中身は、`ε_ℝ` を `ε` の成分から作ったうえで、
  実数の側の固定 `ε_ℝx = x` と複素数の側の固定 `ει(x) = ι(x)` がすべてのベクトルで一致することにある。

## 計算の帰属と範囲

- **厳密**: ℝ の元は AA、ℂ の元は QQbar で持つ。浮動小数点は使わない。
- 範囲外: 選んだ以外の `M_col`・成分。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors
```

実行ログは `logs/` に保存する。
