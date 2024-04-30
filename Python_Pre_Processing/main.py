from PIL import Image
import numpy as np


def compress_image(image_path, output_path):
    # 打开原始图片
    img = Image.open(image_path)

    # 使用convert()函数将每个颜色通道的位数减少到4位
    # 使用lambda函数将每个颜色值映射到只有前4个bits有效
    img = img.convert("RGB")
    img = img.point(lambda x: (x >> 4) * 17)

    # 使用quantize方法将图片的颜色减少到256色
    img = img.quantize(colors=256)

    # 保存修改后的图片
    img.save(output_path)




def resize_image(input_path, output_path, new_size=(640, 480)):
    with Image.open(input_path) as img:
        # 调整图片大小到640x480
        resized_img = img.resize(new_size)  # Image.ANTIALIAS用于保持较好的图片质量

        # 保存调整大小后的图片
        resized_img.save(output_path)



def print_pixel_rgb_values(image_path):
    with Image.open(image_path) as img:
        # 确保图片是RGB模式
        if img.mode != 'RGB':
            img = img.convert('RGB')

        # 获取图片尺寸
        width, height = img.size

        # 遍历每个像素
        for y in range(height):
            for x in range(width):
                rgb = img.getpixel((x, y))
                print(f"Pixel at ({x}, {y}): RGB{rgb}")


def read_image_and_create_color_mapper(image_path):
    # 加载图片
    img = Image.open(image_path)

    # 确保图片是RGBA或RGB格式
    if img.mode not in ['RGB', 'RGBA']:
        img = img.convert('RGB')

    # 将图片转化为numpy数组
    data = np.array(img)

    # 提取所有唯一的颜色
    unique_colors = {tuple(color[:3]) for row in data for color in row}  # 只取RGB，忽略alpha通道
    if len(unique_colors) > 16:
        raise ValueError("图片中有超过256种颜色")

    # 创建从0到255的索引到颜色的映射
    color_mapper = {i: color for i, color in enumerate(unique_colors)}

    # 调整每个颜色的RGB值，只保留每个通道的前4个bit
    adjusted_color_mapper = {}
    for key, color in color_mapper.items():
        adjusted_color = tuple((component & 0xF0) for component in color)  # 与0xF0做AND运算保留前4个bit
        adjusted_color_mapper[key] = adjusted_color

    return adjusted_color_mapper



def count_unique_colors(image_path):
    # 打开图片
    img = Image.open(image_path)
    # 将图片转换为RGBA模式
    img = img.convert('RGB')
    # 获取图片中的所有颜色
    colors = img.getdata()
    # 将颜色数据转换为集合，自动去除重复项
    unique_colors = set(colors)
    # 返回不同颜色的数量
    return len(unique_colors)



# 调用函数并打印结果



# resize_image("./1.jpg","./2.png")
# # 使用函数处理图片
# compress_image("./2.png", "3.png")
# print("Unique colors:", count_unique_colors("./4.png"))
# # 使用实际的图片路径调用这个函数
# color_mapper = read_image_and_create_color_mapper("./4.png")
# print(color_mapper)








from PIL import Image
import numpy as np


def read_image_and_map_colors(file_path, color_mapper):
    # 打开图片
    img = Image.open(file_path)
    # 转换为RGB
    img = img.convert('RGB')
    # 将图片转换为numpy数组
    pixels = np.array(img)

    # 获取图片的尺寸
    height, width = pixels.shape[:2]

    # 初始化一个存储颜色映射索引的数组
    color_index_map = np.zeros((height, width), dtype=int)

    # 遍历每个像素
    for i in range(height):
        for j in range(width):
            # 获取当前像素的颜色
            current_color = pixels[i, j]
            # 初始化一个最小距离，设置为一个很大的数
            min_distance = float('inf')
            # 初始化最匹配的颜色索引
            match_index = None
            # 比较当前颜色和colormapper中的颜色
            for index, color in color_mapper.items():
                # 计算颜色之间的欧式距离
                distance = np.sqrt(sum((c1 - c2) ** 2 for c1, c2 in zip(current_color, color)))
                # 更新最小距离和颜色索引
                if distance < min_distance:
                    min_distance = distance
                    match_index = index
            # 将找到的颜色索引保存到数组中
            color_index_map[i, j] = match_index

    return color_index_map


from PIL import Image
import numpy as np

def load_coe_file(file_path):
    # Read the .COE file and extract 32-bit hexadecimal values
    with open(file_path, 'r') as file:
        data = file.readlines()
    # Extract only the data lines (ignore header and empty or comment lines)
    vector_data = [line.strip().rstrip(',') for line in data if line.strip().startswith(('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'))]
    # Convert hex values to integers and then extract 4-bit values from each
    values = []
    for hex_value in vector_data:
        value = int(hex_value, 16)
        for i in range(8):
            # Extract each 4-bit value from the 32-bit number (from right to left)
            values.append((value >> (4 * i)) & 0xF)
    return values

def create_image_from_values(values, palette, width, height):
    # Create an image from the given values using the palette
    img = Image.new('RGB', (width, height))
    img_data = []
    for index in values:
        # Map each index to the corresponding RGB value in the palette
        r, g, b = palette[index]
        img_data.append((r * 16, g * 16, b * 16))  # Multiply by 16 to scale from 4-bit to 8-bit
    img.putdata(img_data)
    return img


def read_and_process_coe(file_path):
    # 读取文件内容
    with open(file_path, 'r') as file:
        coe_contents = file.readlines()

    # 提取数字部分，忽略非数值行
    values = [int(line.strip().rstrip(',')) for line in coe_contents if
              line.strip().isdigit() or line.strip().rstrip(',').isdigit()]

    # 组合数值
    combined_values = []
    for i in range(0, len(values), 8):
        # 提取8个数值，或者少于8个的剩余部分
        chunk = values[i:i + 8]
        # little endian 组合成32位整数
        combined_value = 0
        for val in reversed(chunk):
            combined_value = (combined_value << 4) | val
        combined_values.append(combined_value)

    # 准备新的 .COE 文件内容
    new_coe_content = [
                          "; This .COE file specifies initialization values for a block memory of depth=, and width=32. In this case, values are specified in hexadecimal format.\n",
                          "memory_initialization_radix=16;\n",
                          "memory_initialization_vector=\n"
                      ] + [f"{value:x},\n" for value in combined_values]

    # 指定新文件的路径
    new_file_path = file_path.replace('.COE', '_32bit.COE')

    # 保存新的文件内容
    with open(new_file_path, 'w') as new_file:
        new_file.writelines(new_coe_content)

    return new_file_path


# 调用函数，处理指定的.COE文件
output_file_path = read_and_process_coe('./1.COE')
print(f"Processed COE file saved as: {output_file_path}")
