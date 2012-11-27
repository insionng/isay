require "time"
module Sort
  
  #计算得分
  def self.hot(date, ups, downs)
    #帖子更新距离建站时间
    t = date - Time.new(2012, 9, 10)
    # 加分 与 减分 之差
    x = (ups.to_i - downs.to_i).abs
    #投票方向
    y = 1 if x > 0
    y = 0 if x ==0
    y =-1 if x < 0

    #帖子受肯定的程度
    z = x if x != 0
    z = 1 if x == 0
    #得出分数
    Math.log10(z) + y*t/45000
  end
  
end
#tme=Time.new(2012, 11, 20)
#puts Sort.hot(tme,199,9)
