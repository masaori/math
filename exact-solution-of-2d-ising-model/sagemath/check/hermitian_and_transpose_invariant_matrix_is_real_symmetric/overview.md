# SageMath Check: hermitian_and_transpose_invariant_matrix_is_real_symmetric

## 対象

**対象ラベル**: `hermitian_and_transpose_invariant_matrix_is_real_symmetric` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_claim_hermitian_and_transpose_invariant_matrix_is_real_symmetric`（エルミートかつ転置で不変な複素行列は実対称）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `(a, −b) = \overline{(a, b)} = \overline{A_{kl}} = (A^*)_{lk} = A_{lk} = (A^⊤)_{kl} = A_{kl} = (a, b)` の 7 行と、第 2 成分から `−b = b` | `check_entry_chains.sage` | `n = 1, 2, 3` の一般の `A`（成分は QQ 上の不定元の対）で、仮定 `A^* = A`・`A^⊤ = A` の成分の等式が生成するイデアル `J` を法として、全ての `k, l` で 1 行ずつ。定義の行は差が恒等的に 0、仮定の行は差が `J` に入る | **PASS** | 全て PASS |
| `b = ½(b + b) = ½((−b) + b) = ½·0 = 0` の 4 行 | 同上 | 2 行目 → 3 行目だけが `J` を法として、ほかは恒等的に | **PASS** | 同上 |
| `A_{kl} = (a, b) = (a, 0) = a_ℂ` の 3 行と結論（成分はすべて実数） | 同上 | `b_{kl}` が `J` に入ること | **PASS** | 同上 |

否定コントロール（7 件）: 仮定 `A^* = A` だけ（`n = 2, 3`）・`A^⊤ = A` だけ（`n = 1, 2, 3`）では、ある成分の虚部が `J` に入らない。
`A^* = A` だけでは、7 行の鎖の 6 行目（`A^⊤ = A`）が `J` を法として外れる（`n = 2, 3`）。`n = 1` では `A^* = A` だけで虚部が 0 になるので、その組は除いた。

## 計算の帰属と範囲

すべて QQ 上の多項式環で厳密に計算した（グレブナー基底によるイデアルの所属判定）。複素数は本文 `definition_of_cc` どおり実数の対で持ち、Sage の複素数は使わない。

## 確かめられない行と理由

定義を書き換えるだけの行（共役転置の定義、`def_matrix_transpose`、`def_complex_conjugate`、`a, b` の取り方、`inclusion_rr_to_cc`）は、検算での組み方そのものが定義なので、隣り合う行の比較は同語反復である。独立な確認は、仮定を使う行がイデアルの所属で判定されることと、否定コントロールが担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh hermitian_and_transpose_invariant_matrix_is_real_symmetric
```

実行ログは `sagemath/check/hermitian_and_transpose_invariant_matrix_is_real_symmetric/logs/` に保存する。
