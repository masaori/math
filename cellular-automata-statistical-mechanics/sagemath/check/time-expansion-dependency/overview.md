# SageMath 検算: 時間展開上の直接依存

## 対象

**対象ラベル**: `claim_one_step_dependency_finite_decidability`

- 併せて検証: `claim_global_flip_characterization`、`def_finite_index_interval`、`claim_event_set_cardinality`、`claim_time_strictly_increases`
- 検証範囲: 大域写像の一点反転による特徴づけ、時間区間とイベント集合の個数、一段依存関係の有限性と所属条件、依存台走査の比較回数上界、一段依存での時刻増加
- 全数範囲: 大域写像と一段依存は $|V|=0,1,2,3$ の全ての $N(v)\subseteq V$ と全局所真理値表。依存台走査は $|N(v)|=0,1,2,3$ の全局所真理値表。時間・個数の検算範囲は各ファイルに記載

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_global_flip_characterization.sage` | 大域写像の一点反転による変化と局所規則の本質的依存台への所属が同値 | PASS | 1,012 個の同値を確認 |
| `check_time_interval_cardinality.sage` | $[0,\tau]_{\mathbb{N}}=\{0,\ldots,\tau\}$ と $|[0,\tau]_{\mathbb{N}}|=\tau+1$ | PASS | $0\leq\tau\leq20$ の 21 区間で一致 |
| `check_event_set_cardinality.sage` | $|E_\tau|=|[0,\tau]_{\mathbb{N}}|\,|V|=(\tau+1)|V|$ | PASS | 64 個の $(\tau,|V|)$ で一致 |
| `check_one_step_membership.sage` | $D_\tau\subseteq E_\tau^2$ と、その所属条件 | PASS | 1,408 関係・89,160 組の所属を確認 |
| `check_support_scan_bound.sage` | 依存台走査の結果と比較回数上界 $|N(v)|2^{|N(v)|}$ | PASS | 278 真理値表で一致・上界内 |
| `check_time_strictly_increases.sage` | $t=s+1$ ならば $s<t$ | PASS | 210 個の一段時刻対で確認 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、一般の有限集合・任意の $\tau\in\mathbb{N}$ に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- 全て有限集合、非負整数、2 元集合の等号・大小比較として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/time-expansion-dependency/check_*.sage; do sage "$file"; done
```
