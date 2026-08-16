# SageMath 検算: 反復モノイドの衝突開始位置と主イデアル列の安定位置

## 対象

**対象ラベル**: `claim_iterate_monoid_first_stable_equals_min_collision_start`

- 併せて検証するラベル: `def_iterate_monoid_collision_start`、`claim_iterate_monoid_tail_equality_iff_collision_start`、`claim_iterate_monoid_tails_strict_then_stable`
- 検証範囲: 衝突開始位置 $\{n\mid\exists p>0,\ F^n=F^{n+p}\}$ の非空性と最小値 $\mu_F$、$I_n(F)=I_{n+1}(F)\iff\exists p>0,\ F^n=F^{n+p}$ の両方向、$n<\mu_F$ での真の減少と $n\ge\mu_F$ での一定、最初の安定位置と $\mu_F$ の一致
- 全数範囲: セル数 $0$ の唯一の大域写像、および $1\le|V|\le3$ の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_collision_start_min.sage` | 衝突開始位置の集合が空でなく、最小値 $\mu_F$ が最初の衝突 $F^i=F^j$ の $i$ に一致し、$p=j-i$ が証人で、$n<\mu_F$ は衝突開始位置でないこと | PASS | 769 写像で成立 |
| `check_tail_equality_iff_collision.sage` | 各 $n$（$0\le n\le 2j+2$）で、順方向は $F^n=F^{n+0}\in I_n=I_{n+1}$ から $k$ を取り $(n+1)+k=n+(1+k)$、$p=1+k>0$ を一行ずつ、逆方向は $n<n+p$、$n+1\ge n$ から $I_{n+1}=I_n$ を検査 | PASS | 769 写像・6,431 行で成立 |
| `check_strict_then_stable.sage` | $n<\mu_F$ で $I_{n+1}\subseteq I_n$（tails_descend）、$n$ が衝突開始位置でないこと、$I_{n+1}\ne I_n$、真部分集合。$n\ge\mu_F$（有限範囲）で $I_n=I_{\mu_F}$ | PASS | 769 写像・厳密減少 650 行・安定 5,781 行で成立 |
| `check_first_stable_equals_mu.sage` | 有限代表 $P_F$ と合成で走査した後尾集合の列で、最初に $I_n=I_{n+1}$ となる $n$ が定義から独立に求めた $\mu_F$ に等しいこと | PASS | 769 写像・後尾集合の比較 1,419 回で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- $|V|=1,2,3$ では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- 衝突開始位置の $\exists p>0$ と後尾集合の $k\in\mathbb N$ の全量化は、衝突指数 $j$ を超えると新しい反復写像が現れないことを使い、指数 $j$ までの有限列挙で尽くす。「すべての $n\ge\mu_F$」の普遍量化は有限範囲で検査し、普遍的な根拠は人手証明である。
- 全て有限集合の写像（配位番号の真理値表）の等号、非負整数の加減と大小比較として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-stabilization-index/check_*.sage; do sage "$file"; done
```
