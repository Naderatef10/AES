%sub byte function is one of the four main algorithms in the AES-128 algorithms
%in this model the function takes the input state matrix as binary and perform proper subsititution
%based on the s_box table which is stated in the Fips standard
%the function returns the state matrix in binary
%inputs -> state matrix from previous step
%outputs -> state matrix after substitution of bytes.
function state = Sub_byte(input_state)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% S_Box declaration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
state=input_state;
s_box =[
    99   124   119   123   242   107   111   197    48     1   103    43   254   215   171   118;
   202   130   201   125   250    89    71   240   173   212   162   175   156   164   114   192;
   183   253   147    38    54    63   247   204    52   165   229   241   113   216    49    21;
     4   199    35   195    24   150     5   154     7    18   128   226   235    39   178   117;
     9   131    44    26    27   110    90   160    82    59   214   179    41   227    47   132;
    83   209     0   237    32   252   177    91   106   203   190    57    74    76    88   207;
   208   239   170   251    67    77    51   133    69   249     2   127    80    60   159   168;
    81   163    64   143   146   157    56   245   188   182   218    33    16   255   243   210;
   205    12    19   236    95   151    68    23   196   167   126    61   100    93    25   115;
    96   129    79   220    34    42   144   136    70   238   184    20   222    94    11   219;
   224    50    58    10    73     6    36    92   194   211   172    98   145   149   228   121;
   231   200    55   109   141   213    78   169   108    86   244   234   101   122   174     8;
   186   120    37    46    28   166   180   198   232   221   116    31    75   189   139   138;
   112    62   181   102    72     3   246    14    97    53    87   185   134   193    29   158;
   225   248   152    17   105   217   142   148   155    30   135   233   206    85    40   223;
   140   161   137    13   191   230    66   104    65   153    45    15   176    84   187    22];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Substitution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% the state array is binary we will loop on each byte row by row %%%%%%%%%%%
j = 1;
first_byte = [];
second_byte = [];
%%%%%%%%%%%%%%% looping on each word in the 4 words of 128 bit input block %%%%%%%%
for i = 1:4
    %%%%%%%% looping on 4 bytes in each word 
    j=1;
  for byte = 1:4
      %first_byte is converted to decimal to find the equivelance in the s_box,
      %the s_box used in the model is based on decimal literals so we need to convert from binary representation to decimal
      %this occurs in the first_byte,second_byte operations
    first_byte = binaryVectorToDecimal(input_state(i,j:j+4-1)); %%%% extracting first byte %%%% 
    second_byte = binaryVectorToDecimal(input_state(i,j+4:j+8-1)); %%%%%%%%%%% extracting second byte %%%%%%%%%
    new_byte = s_box(first_byte+1,second_byte+1); %%%% extracting new byte from sbox%%%%
    new_byte = decimalToBinaryVector(new_byte,8); %%%% converting the new byte from decimal to binary
    state(i,j:j+4-1)= new_byte(1:4); %storing the new byte in binary representation as 8 bits (first 4 bits)
    state(i,j+4:j+8-1)= new_byte(5:8);%storing the new byte in binary representation as 8 bits (second 4 bits)
    j = j + 8;
  end 
end 

end 