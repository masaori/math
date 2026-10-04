# 対角変換の両側逆行列

**対象ラベル**: `claim_diagonal_gauge_inverse`。定義は `def_twist_parity` と `def_diagonal_gauge`。

整数指数と円分体 $\mathbb Q(\zeta_8)$ 内で厳密に計算し、浮動小数点は使わない。
$L=1,2,3$、四ねじれ、$z^4=-1$ の四根の48通りから、方向番号・切断線を直接使って行列を構成する。
逆行列候補は逆行列計算から作らず、独立の正指数の式で構成する。`check.sage` では
SageMath の逆行列とも比較する。一般の $L$ の証明は本文と Lean が担い、この有限検算とは区別する。

準備の整数冪は各辺の $(p,q)$ と逆順の $(-q,-p)$、行列成分は両方の積の全成分を検査する。
零項だけは各 $e\ne g$ について $f=g$ と $f=g+1\pmod{4L^2}$ を取り、
右因子が非零と零になる二種類を調べる。全三添字の全数検査とはしない。

| ファイル | 本文の等号 | ステータス | 検査数 |
|---|---|---|---:|
| `check.sage` | 根・指数の所属と独立な逆行列計算 | PASS | 48行列 |
| `check_associate_outer.sage` | 外側の積の結合則 | PASS | 1,792 |
| `check_associate_inner.sage` | 内側の積の結合則 | PASS | 1,792 |
| `check_combine_q_powers.sage` | q の整数冪の加法則 | PASS | 1,792 |
| `check_cancel_q_exponents.sage` | q と負の q の和 | PASS | 1,792 |
| `check_q_zero_power.sage` | q の取消後の零乗 | PASS | 1,792 |
| `check_remove_unit.sage` | 単位元との積 | PASS | 1,792 |
| `check_combine_p_powers.sage` | p の整数冪の加法則 | PASS | 1,792 |
| `check_cancel_p_exponents.sage` | p と負の p の和 | PASS | 1,792 |
| `check_p_zero_power.sage` | p の取消後の零乗 | PASS | 1,792 |
| `check_forward_weight.sage` | 順方向の u の定義 | PASS | 896 |
| `check_forward_inverse_weight.sage` | 順方向の v の定義 | PASS | 896 |
| `check_forward_cancellation.sage` | 準備の等式を順方向へ適用 | PASS | 896 |
| `check_backward_inverse_weight.sage` | 逆方向の v の定義 | PASS | 896 |
| `check_backward_weight.sage` | 逆方向の u の定義 | PASS | 896 |
| `check_backward_double_negative_p.sage` | p の二重負号 | PASS | 896 |
| `check_backward_double_negative_q.sage` | q の二重負号 | PASS | 896 |
| `check_backward_cancellation.sage` | 準備の等式を逆方向へ適用 | PASS | 896 |
| `check_zero_entry.sage` | 対角以外の成分 | PASS | 96,768 |
| `check_zero_product.sage` | 零の左乗法 | PASS | 96,768 |
| `check_matrix_product.sage` | 行列積の有限和 | PASS | 50,176 |
| `check_remove_zero_terms.sage` | 零項を有限和から除く | PASS | 50,176 |
| `check_left_diagonal_entry.sage` | 左対角成分の記号 | PASS | 50,176 |
| `check_right_diagonal_entry.sage` | 右対角成分の記号 | PASS | 1,792 |
| `check_diagonal_product.sage` | 対角成分の積 | PASS | 1,792 |
| `check_identity_diagonal.sage` | 単位行列の対角成分 | PASS | 1,792 |
| `check_right_zero_entry.sage` | 右行列の対角以外の成分 | PASS | 48,384 |
| `check_right_zero_product.sage` | 零の右乗法 | PASS | 48,384 |
| `check_identity_off_diagonal.sage` | 単位行列の対角以外の成分 | PASS | 48,384 |

実行方法（プロジェクト直下）:

```sh
micromamba run -p /home/masaori/.local/share/math-mamba/envs/sage sage -c "__file__ = 'sagemath/check/diagonal-gauge-inverse/check.sage'; load(__file__)"
```

2026-10-04 実行: 48行列の独立比較と、行別28本・計517,888等式がすべて通過した。
単位行列を各成分ごとに再構成していた初回を中断し、各行列に一度の構成へ整理した後、
検査範囲を変えずに全件を再実行した。
