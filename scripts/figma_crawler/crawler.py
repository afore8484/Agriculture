import requests
from bs4 import BeautifulSoup
import os
import re
from urllib.parse import urljoin, urlparse

# 目标URL
target_url = 'https://card-kite-76534082.figma.site/'
# 保存目录
save_dir = 'scripts/figma_crawler/output'

# 创建保存目录
os.makedirs(save_dir, exist_ok=True)
os.makedirs(os.path.join(save_dir, 'css'), exist_ok=True)
os.makedirs(os.path.join(save_dir, 'js'), exist_ok=True)
os.makedirs(os.path.join(save_dir, 'html'), exist_ok=True)
os.makedirs(os.path.join(save_dir, 'json'), exist_ok=True)

# 已爬取的URL集合
crawled_urls = set()

# 提取链接
def extract_links(soup, base_url):
    links = []
    for a_tag in soup.find_all('a', href=True):
        href = a_tag['href']
        absolute_url = urljoin(base_url, href)
        if absolute_url not in crawled_urls:
            links.append(absolute_url)
    return links

# 提取并保存CSS
def save_css(soup, base_url):
    css_files = []
    for link_tag in soup.find_all('link', rel='stylesheet'):
        if 'href' in link_tag.attrs:
            css_url = urljoin(base_url, link_tag['href'])
            css_files.append(css_url)
            
            # 保存CSS内容
            try:
                css_response = requests.get(css_url)
                if css_response.status_code == 200:
                    css_filename = os.path.basename(urlparse(css_url).path)
                    if not css_filename:
                        css_filename = f'css_{len(css_files)}.css'
                    css_path = os.path.join(save_dir, 'css', css_filename)
                    with open(css_path, 'w', encoding='utf-8') as f:
                        f.write(css_response.text)
                    print(f'Saved CSS: {css_filename}')
            except Exception as e:
                print(f'Error saving CSS {css_url}: {e}')
    return css_files

# 提取并保存JSON文件和preload的JS文件
def save_json(soup, base_url):
    json_urls = []
    
    # 查找preload标签中的URL
    for link_tag in soup.find_all('link', rel='preload'):
        if 'href' in link_tag.attrs:
            url = urljoin(base_url, link_tag['href'])
            
            if link_tag.get('as') == 'fetch':
                # 处理JSON文件
                json_urls.append(url)
                print(f'Found JSON URL from preload: {url}')
                
                # 保存JSON内容
                try:
                    json_response = requests.get(url)
                    if json_response.status_code == 200:
                        # 保持原始路径结构
                        json_path_rel = urlparse(url).path.lstrip('/')
                        json_path = os.path.join(save_dir, 'json', json_path_rel)
                        os.makedirs(os.path.dirname(json_path), exist_ok=True)
                        with open(json_path, 'w', encoding='utf-8') as f:
                            f.write(json_response.text)
                        print(f'Saved JSON: {json_path_rel}')
                except Exception as e:
                    print(f'Error saving JSON {url}: {e}')
            elif link_tag.get('as') == 'script':
                # 处理JS文件
                print(f'Found JS URL from preload: {url}')
                
                # 保存JS内容
                try:
                    js_response = requests.get(url)
                    if js_response.status_code == 200:
                        js_filename = os.path.basename(urlparse(url).path)
                        if not js_filename:
                            js_filename = f'preload_js_{len(json_urls)}.js'
                        js_path = os.path.join(save_dir, 'js', js_filename)
                        with open(js_path, 'w', encoding='utf-8') as f:
                            f.write(js_response.text)
                        print(f'Saved preload JS: {js_filename}')
                except Exception as e:
                    print(f'Error saving preload JS {url}: {e}')
    
    return json_urls

# 提取并保存JS
def save_js(soup, base_url):
    js_files = []
    # 查找有src属性的script标签
    for script_tag in soup.find_all('script', src=True):
        js_url = urljoin(base_url, script_tag['src'])
        js_files.append(js_url)
        print(f'Found JS URL: {js_url}')
        
        # 保存JS内容
        try:
            js_response = requests.get(js_url, timeout=10)
            print(f'JS response status: {js_response.status_code}')
            if js_response.status_code == 200:
                js_filename = os.path.basename(urlparse(js_url).path)
                if not js_filename:
                    js_filename = f'js_{len(js_files)}.js'
                js_path = os.path.join(save_dir, 'js', js_filename)
                with open(js_path, 'w', encoding='utf-8') as f:
                    f.write(js_response.text)
                print(f'Saved JS: {js_filename}')
            else:
                print(f'Failed to get JS: {js_url}, status code: {js_response.status_code}')
        except Exception as e:
            print(f'Error saving JS {js_url}: {e}')
    
    # 查找内联script标签中的JS代码和import语句
    for i, script_tag in enumerate(soup.find_all('script', src=None)):
        if script_tag.string:
            # 保存内联JS代码
            js_filename = f'inline_js_{i}.js'
            js_path = os.path.join(save_dir, 'js', js_filename)
            with open(js_path, 'w', encoding='utf-8') as f:
                f.write(script_tag.string)
            print(f'Saved inline JS: {js_filename}')
            
            # 解析import语句中的JS文件
            import_pattern = r"import.*from ['\"](.*?)['\"]"
            import_matches = re.findall(import_pattern, script_tag.string)
            for import_path in import_matches:
                if import_path.startswith('/'):
                    js_url = urljoin(base_url, import_path)
                    js_files.append(js_url)
                    print(f'Found imported JS URL: {js_url}')
                    
                    # 保存import的JS内容
                    try:
                        js_response = requests.get(js_url, timeout=10)
                        print(f'Imported JS response status: {js_response.status_code}')
                        if js_response.status_code == 200:
                            js_filename = os.path.basename(urlparse(js_url).path)
                            if not js_filename:
                                js_filename = f'imported_js_{len(js_files)}.js'
                            js_path = os.path.join(save_dir, 'js', js_filename)
                            with open(js_path, 'w', encoding='utf-8') as f:
                                f.write(js_response.text)
                            print(f'Saved imported JS: {js_filename}')
                        else:
                            print(f'Failed to get imported JS: {js_url}, status code: {js_response.status_code}')
                    except Exception as e:
                        print(f'Error saving imported JS {js_url}: {e}')
    
    return js_files

# 爬取页面
def crawl_page(url):
    if url in crawled_urls:
        return
    
    print(f'Crawling: {url}')
    crawled_urls.add(url)
    
    try:
        response = requests.get(url)
        if response.status_code != 200:
            print(f'Error accessing {url}: {response.status_code}')
            return
        
        # 保存HTML内容
        html_filename = os.path.basename(urlparse(url).path)
        if not html_filename:
            html_filename = 'index.html'
        html_path = os.path.join(save_dir, 'html', html_filename)
        with open(html_path, 'w', encoding='utf-8') as f:
            f.write(response.text)
        print(f'Saved HTML: {html_filename}')
        
        # 解析页面
        soup = BeautifulSoup(response.text, 'html.parser')
        
        # 提取并保存CSS
        css_files = save_css(soup, url)
        
        # 提取并保存JSON文件
        json_files = save_json(soup, url)
        
        # 提取并保存JS
        js_files = save_js(soup, url)
        
        # 提取链接
        links = extract_links(soup, url)
        
        # 保存链接到文件
        with open(os.path.join(save_dir, 'links.txt'), 'a', encoding='utf-8') as f:
            for link in links:
                f.write(link + '\n')
        
        # 递归爬取链接
        for link in links:
            # 只爬取同一域名下的链接
            if urlparse(link).netloc == urlparse(target_url).netloc:
                crawl_page(link)
                
    except Exception as e:
        print(f'Error crawling {url}: {e}')

# 开始爬取
print('Starting crawl...')
crawl_page(target_url)
print('Crawl completed!')
print(f'Total URLs crawled: {len(crawled_urls)}')
print(f'Output saved to: {save_dir}')
