# SageMath Check: finite_double_sum_of_matrices_interchange

## 対象

**対象ラベル**: `finite_double_sum_of_matrices_interchange`

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_finite_double_sum_of_matrices_interchange`（行列の二重の有限和は和の順序を入れ替えても等しい）
- 範囲: 証明の成分の 5 等号の鎖と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `(Σ_aΣ_b X_{a,b})_{ik} = Σ_a(Σ_b X_{a,b})_{ik} = Σ_aΣ_b (X_{a,b})_{ik} = Σ_bΣ_a (X_{a,b})_{ik} = Σ_b(Σ_a X_{a,b})_{ik} = (Σ_bΣ_a X_{a,b})_{ik}` と主張 | `check_entry_chain.sage` | X_{a,b} の成分を `QQ` 上の多項式環の不定元に置き、(m, n) ∈ {1,2,3}^2、r, s = 1..4 の全ての成分で各行を本文の成分の式（左から順に足す有限和）で組んで隣と比べる。主張を Sage の行列演算とも比べる。対照: 片方の添字を固定した和どうしは一致しない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: すべて `QQ` 上の多項式環。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。浮動小数点は使わない。
- **作り方で自明な比較**: 成分への分解の 4 行（`finite_sum_of_matrices_entrywise`）は両辺を同じ成分の式から作るので、比較は値が通ることを見るだけである。中身を持つのは第 3 等号（ℂ の有限和の順序交換）である。
- 範囲外: r ≥ 5 または s ≥ 5、m または n ≥ 4。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_double_sum_of_matrices_interchange
```

実行ログは `logs/` に保存する。
