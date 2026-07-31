# cycle 21 / T3 Pure: 定理 J7 の最後の仮定 (B\*) を落とす — 対象ラベル

対応する証明本体: [`outputs/reports/cycle21_T3_drop_assumption_B_star.md`](../../../outputs/reports/cycle21_T3_drop_assumption_B_star.md)

## 対象ラベル（論文本文のブロック）

| ラベル | 本検証が支える内容 |
|---|---|
| `paper_prop_K` | 本検証の主対象。$n\ell^n$ の係数 $b=\sum_i m_i$ (K6) から**仮定 (B\*) が落ちる**こと。cycle 20 が (B\*) 付きでしか言えなかった主張が無条件になる |
| `paper_prop_J` | 定理 J7 が置いていた 3 つの仮定 (F)・(N)・(B\*) が**すべて不要**になること（(F) は cycle 19 系 J10′、(N) は cycle 20 系 W5、(B\*) が本検証） |
| `paper_prop_G_infty` | $S_\infty$（＝例外直線）の各点の重複度 $m_i$ が $n\ell^n$ の係数を決めること。$\ell=2$ を除外しないこと |

> **本サイクルの申し送り**: cycle 21 step 1（本検証）は論文本文（`structured-latex/` と
> `structured-latex-en/`）を触らない（転記事故と並行作業の衝突を避けるため、本文への反映は
> step 4 が一括で行う）。したがって本ディレクトリは step 4 が `verification` を張るまで
> **linkage 検査では「孤立」と表示される**。これは意図的であり、対応が切れているのではない。

## 検証する命題（証明本体との対応）

| 証明本体の番号 | 内容 | Step | スクリプト |
|---|---|---|---|
| 補題 Q1′ | 整数のままの分解 $\tilde E=B\,G+\ell H$ | A | `q1_decomposition.sage` |
| 補題 Q2 | $\bar G$ が原始二項式因子を持たない／$\theta_G$ が至る所有限・有界 | B | `q1_decomposition.sage` |
| （$(1.3)$） | $b=\sum_i m_i$ と $b=\sum_{P\in S_\infty}j^*(P)$ の一致（cycle 20 定理 W4 の再現） | C | `q1_decomposition.sage` |
| 補題 Q3 | 数え上げ恒等式 $\sum_P\ell^{\rho_v(P)}=(M-1)\varphi(\ell^M)+2\ell^M$ | D | `q1_decomposition.sage` |
| 補題 Q0 | アルキメデス粗上界 $\hat\theta_M(P)\le\varphi(\ell^M)\log_\ell C_0$ | E | `q1_decomposition.sage` |
| **定理 Q4** | 「良い点」での**等号** $\hat\theta_M(P)=\beta_P+\theta_G(P)$ | F | `q2_pointwise.sage` |
| 補題 Q5 | 「悪い点」の個数が $M$ に依らず有界 | G | `q2_pointwise.sage` |
| §7.1 | (B\*) の破れが「悪い点」でしか起きないこと（(B\*) が何を保証していたかの切り分け） | H/I | `q2_pointwise.sage` |
| **定理 Q1** | $\bigl|\Theta_M-b M\varphi(\ell^M)\bigr|\le C\ell^M$ を**証明の明示定数**で確認 | J/L/M | `q3_aggregate.sage` |
| （実装の健全性） | $\sum_M\Theta_M$ から作った $\mathrm{ord}_\ell(\kappa_n)$ と Matrix–Tree の照合 | K | `q3_aggregate.sage` |

## 実行

```bash
cd integrable-lattice/sagemath/check/cycle21_T3_b_star
sage q1_decomposition.sage > q1_decomposition.out 2>&1
sage q2_pointwise.sage     > q2_pointwise.out     2>&1
sage q3_aggregate.sage     > q3_aggregate.out     2>&1
```

## 実行ステータスと結果

| スクリプト | 実測所要 | FAIL | 打ち切り |
|---|---|---|---|
| `q1_decomposition.sage` | **1.6 秒** | **0** | **0** |
| `q2_pointwise.sage` | **16.6 秒** | **0** | **0** |
| `q3_aggregate.sage` | **2.3 秒** | **0** | **0** |

**設計要件（cycle 19・20 で 3 回再発した「掃引起動直後にセッションが終了」への対策）**:
1 本のスクリプトの壁時計上限を 20 分以内に設計した。実測はいずれも 20 秒以内で、
3 本とも前景で完走した。**打ち切りは 1 件も無い。**

詳細（手順・限界・結果の内訳）は [README.md](README.md) と各 `.out`。
